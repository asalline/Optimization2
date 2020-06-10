%Defining identity matrix "I" and Pauli matrices pauli_x, pauli_y, pauli_z.

global original_rho

I = [1, 0; 0, 1];

pauli_x = [0, 1; 1, 0];
px = pauli_x;

pauli_y = [0, -1*i; 1*i, 0];
py = pauli_y;

pauli_z = [1, 0; 0, -1];
pz = pauli_z;

pauli_base = {I, px, py, pz};

finaloperator = 1;

pauli_new = cell(1, length(pauli_base)*length(pauli_base));

%used = {pauli_base{2}, pauli_base{4}, pauli_base{1}};
n = 1;

for j = 1:length(pauli_base)
    for k = 1:length(pauli_base)
        pauli_new{n} = kron(pauli_base{j}, pauli_base{k});
        means(n) = trace(pauli_new{n}*original_rho);
        n = n+1;
    end
end

global pauli_new
global means

