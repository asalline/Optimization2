%This function contains all the non linear constraints that are used to
%optimize with "fmincon_rho2".

function [c, ceq] = nlcon2(x)
%Defining used things. "original_rho" is global object that comes from
%random density matrix generator.
global restrictions
global s
global means
error = 0.0001*rand;
c16 = 0;, c15 = c16;, c14 = c15;, c13 = c14;, c12 = c13;, c11 = c12;, ...
    c10 = c11;, c9 = c10;, c8 = c9;, c7 = c8;, c6 = c7;, c5 = c6;, ...
    c4 = c5;, c3 = c4;, c2 = c3;, c1 = c2;
c = [c1;c2;c3;c4;c5;c6;c7;c8;c9;c10;c11;c12;c13;c14;c15];

%These are correlating to Pauli basis by ceq n = Pauli_new{n+1}
ceq1 = abs(x(1) - means(2)); %Pauli_new{2}
ceq2 = abs(x(2) - means(3));
ceq3 = abs(x(3) - means(4));
ceq4 = abs(x(4) - means(5));
ceq5 = abs(x(5) - means(6));
ceq6 = abs(x(6) - means(7));
ceq7 = abs(x(7) - means(8));
ceq8 = abs(x(8) - means(9));
ceq9 = abs(x(9) - means(10));
ceq10 = abs(x(10) - means(11));
ceq11 = abs(x(11) - means(12));
ceq12 = abs(x(12) - means(13));
ceq13 = abs(x(13) - means(14));
ceq14 = abs(x(14) - means(15));
ceq15 = abs(x(15) - means(16)); %Pauli_new{16}

ceq_all = [ceq1;ceq2;ceq3;ceq4;ceq5;ceq6;ceq7;ceq8;ceq9;ceq10;ceq11;ceq12;ceq13;ceq14;ceq15];

%ceq-constraints correlating to different elements of the matrix:
%       Diagonal elements: 3,12,15
%       "Reversed" diagonal elements: 5,6,9,10
%       Left-top & right-bottom off-diagonals: 1,2,13,14
%       Left-bottom & right-top off-diagonals: 4,7,8,11

if restrictions == 1
    %Free to modify section where one can put its own constraints. Also may
    %need to modify if-loop.
    if s == 1
        %Diag
        ceq = [ceq1;ceq2;ceq4;ceq5;ceq6;ceq7;ceq8;ceq9;ceq10;ceq11;ceq13;ceq14];
    elseif s == 2
        %Rev-diag
        ceq = [ceq1;ceq2;ceq3;ceq4;ceq7;ceq8;ceq11;ceq12;ceq13;ceq14;ceq15];
    elseif s == 3      
        %L-T
        ceq = [ceq3;ceq4;ceq5;ceq6;ceq7;ceq8;ceq9;ceq10;ceq11;ceq12;ceq15];
    else       
        %L-B
        ceq = [ceq1;ceq2;ceq3;ceq5;ceq6;ceq9;ceq10;ceq12;ceq13;ceq14;ceq15];
    end
elseif restrictions == 2
    %Tähän random-rajoituksilla tuleva.
    for j = 1:amount_of_randoms
        ceq(j) = ceq_all(randi([1, 15]))
        %PITÄIS VALITA VAIN JA AINOASTAAN ERI MITTAUKSET!!!
    end
    ceq = ceq.';
else
    %All the constraints. Should give perfectly optimized density matrix.
    ceq = ceq_all;
end


%Placeholder for every ceq-constraint, just in case.
%ceq = [ceq1;ceq2;ceq3;ceq4;ceq5;ceq6;ceq7;ceq8;ceq9;ceq10;ceq11;ceq12;ceq13;ceq14;ceq15];