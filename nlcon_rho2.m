%This function contains all the non linear constraints that are used to
%optimize with "fmincon_rho2".

function [c, ceq] = nlcon2(x)
%Defining used things. "original_rho" is global object that comes from
%random density matrix generator.
global means
error = ((0.0001*rand)+(0.0001*rand)+(0.0001*rand))/3;
c1 = 0;
c2 = 0;
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
c7 = 0;
c8 = 0;
c9 = 0;
c10 = 0;
c11 = 0;
c12 = 0;
c13 = 0;
c14 = 0;
c15 = 0;
ceq1 = abs(x(1) - means(2));
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
ceq15 = abs(x(15) - means(16));

c = [c1;c2;c3;c4;c5;c6;c7;c8;c9;c10;c11;c12;c13;c14;c15];
ceq = [ceq1;ceq2;ceq3;ceq4;ceq5;ceq6;ceq7;ceq8;ceq9;ceq10;ceq11;ceq12;ceq13;ceq14;ceq15];

%For the complex valued density matrices "ceq2" needs to be know, since it
%holds the information about imaginary parts.
%In fact for one qubit density matrix one needs all the measurements to
%minimize the vector x and thus obtaining the density matrix.