%This function triggers the solver and then calculates and plots the
%fidelity (closeness of two quantum states) with every iteration step.

%Needed scripts to operate: RDM_parempi.m & fmincon_rho2.m & nlcon_rho2.m &
%                           paulimatrices.m

%There is four variables:
%   repeats: amount of the times this script generates new random density
%            matrix and tries to optimize it (natural number, default: 1)
%   qubits: amount of qubits to use (natural number, default: 1)
%   ranknum: rank of the density matrix (natural number, default: 1)
%   real: defines if the density matrix is real or complex valued
%         (real valued = 1, complex valued = 0, default: 1)
restrictions = 3;
amount_of_randoms = 5;
clear collection s means_length own_restriction
for s = 1
    clearvars -except collection s means_length own_restriction, clc
    repeats = 25;
    qubits = 2;
    ranknum = 2;
    real = 1;
    fidelities = cell(1, repeats);
    x0 = zeros(1,15);

    %This loop repeats process for wanted times.
    for jj = 1:repeats
    RDM_parempi;
    paulimatrices;
    [x, fval, history] = fmincon_rho2(x0);

    %For each time processed this loop calculates the fidelity between the
    %original density matrix generated and the optimized density matrix.
    for k = 1:length(history)
        fidelity(k) =...
            (trace(sqrtm(sqrtm(history{k})*original_rho*sqrtm(history{k}))))^2;
    end
    steps = [1:1:length(fidelity)];
    fidelities{jj} = fidelity;

    %Figure that plots fidelities on y-axis with respect to iteration steps on
    %x-axis.
    figure(1);
    hold on
    plot(steps, fidelity, 'k.', 'markersize', 5);
    xlabel('Iteration steps');
    ylabel('Fidelity');
    %plot(steps, fidelity, 'r--');

    rho = history{end};
    disp('Optimized density matrix')
    disp(rho)
    disp('Original density matrix')
    disp(original_rho)

    clear fidelity
    end

    %Next part calculates needed size for the vector that is needed to
    %calculate means between each full optimization.
    for kk = 1:repeats
        step = length(fidelities{kk});
        all_steps(kk) = step;
    end
    max_length = max(all_steps);
    means = zeros(1, max_length);
    amount_of_steps_per_iteration = means;

    for l = 1:repeats
        fidelity =...
            [fidelities{l}, zeros(1, max_length - length(fidelities{l}))];
        means = means + fidelity;
    end

    scaled_means = nan(max_length, length(fidelities));
    for j = 1:size(scaled_means,2)
    scaled_means(1:length(cell2mat(fidelities(j))),j) =...
        cell2mat(fidelities(j));
    end

    scaled_means = nanmean(scaled_means,2);
    means = means/repeats;
    steps = [1:1:length(means)];

    plot(steps, scaled_means, 'g.', 'markersize', 6);
    plot(steps, means, 'r.', 'markersize', 6);
    xlabel('Iteration steps');
    ylabel('Mean fidelity');
    red = plot(steps, means, 'r--');
    green = plot(steps, scaled_means, 'g--');
    %title({['Density matrix optimization, iterated: ', num2str(repeats),...
    %    ' times']; ['Amount of qubits used: ', num2str(qubits),...
    %    ', Rank of the density matrices: ', num2str(ranknum)]})

    %legend([green, red], 'Scaled mean', 'Not scaled mean')
    means_length(s) = length(scaled_means);
    collection{s} = scaled_means;
end
title({['Density matrix optimization, iterated: ', num2str(repeats),...
        ' times']; ['Amount of qubits used: ', num2str(qubits),...
        ', Rank of the density matrices: ', num2str(ranknum)]})

    legend([green, red], 'Scaled mean', 'Not scaled mean')

len = min(means_length);
new_steps = (1:1:len);
figure(2)
hold on
for k = 1
    collection{k} = collection{k}(1:len);
    plot(new_steps, collection{k}, '--');
end
hold off
