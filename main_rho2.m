%This function triggers the solver and then calculates and plots the
%fidelity (closeness of two quantum states) with every iteration step.


repeats = 25;
fidelities = cell(1, repeats);
x0 = zeros(1,15);
qubits = 2;
ranknum = 7;
real = 1

for jj = 1:repeats
RDM_parempi;
paulimatrices;
[x, fval, history] = fmincon_rho2(x0);

for k = 1:length(history)
    fidelity(k) = (trace(sqrtm(sqrtm(history{k})*original_rho*sqrtm(history{k}))))^2;
end
steps = [1:1:length(fidelity)];
fidelities{jj} = fidelity

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

for l = 1:repeats
    fidelity = [fidelities{l}, zeros(1, max_length - length(fidelities{l}))];
    means = means + fidelity;
end

means = means/repeats;
steps = [1:1:length(means)];
var(means)

plot(steps(1:1:15), means(1:1:15), 'k.', 'markersize', 5);
xlabel('Iteration steps');
ylabel('Mean fidelity');
plot(steps, fidelity, 'r--');
hold off