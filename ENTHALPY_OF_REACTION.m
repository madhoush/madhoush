%SECTION1 : REACTION INFORMATION
r = input('Enter number of reactants \n');
p = input('Enter number of products \n');
for i=1:(r+p)
    if i<=r
        fprintf('Enter stoichiometric coefficient for reactant %d \n',i);
        st_co(i) = input('');%#ok
    else
        j = (i-r);
        fprintf('Enter stoichiometric coefficient for product %d \n',j);
        st_co(i) = input(''); %#ok
    end
end

%SECTION2 : THERMODYNAMIC PARAMETERS
R = 8.314;
T0 = input('Enter reference temperature (K) \n');
DH0 = input('Enter reaction enthalpy in reference temperature (j) \n');
T = input('Enter the temperature that you want to calculate heat of reaction (K) \n');
fprintf('Enter A,B,C,D for Cp calculation \n ...Cp = A + BT + CT^2 + DT^(-2) \n');
%A
for i=1:(r+p)
    if i<=r
        fprintf('Enter A for reactant %d \n',i);
        A(i) = input('');%#ok
    else
        j = (i-r);
        fprintf('Enter A for product %d \n',j);
        A(i) = input('');%#ok 
    end
end
%B
BB = input('do you have B?(yes or no )\n','s');
switch (BB)
    case 'yes'
        for i=1:(r+p)
            if i<=r
                fprintf('Enter B for reactant %d \n',i);
                B(i) = input('');%#ok
            else
                j = (i-r);
                fprintf('Enter B for product %d \n',j);
                B(i) = input(''); %#ok
            end
        end
    case 'no'
        B = zeros(1,(r+p));
    otherwise
        BB = input('do you have B?(yes or no )\n');
end
%C
CC = input('do you have C?(yes or no )\n','s');
switch (CC)
    case 'yes'
        for i=1:(r+p)
            if i<=r
                fprintf('Enter C for reactant %d \n',i);
                C(i) = input('');%#ok
            else
                j = (i-r);
                fprintf('Enter C for product %d \n',j);
                C(i) = input(''); %#ok
            end
        end
    case 'no'
        C = zeros(1,(r+p));
    otherwise
        CC = input('do you have C?(yes or no )\n');
end
%D
DD = input('do you have D?(yes or no )\n','s');
switch (DD)
    case 'yes'
        for i=1:(r+p)
            if i<=r
                fprintf('Enter D for reactant %d \n',i);
                D(i) = input('');%#ok
            else
                j = (i-r);
                fprintf('Enter D for product %d \n',j);
                D(i) = input(''); %#ok
            end
        end
    case 'no'
        D = zeros(1,(r+p));
    otherwise
        DD = input('do you have D?(yes or no )\n');
end   

%SECTION3 : CALCULATIONS
GA = sum(st_co.*A);
GB = sum(st_co.*B);
GC = sum(st_co.*C);
GD = sum(st_co.*D);
DH_2 =R*(GA*(T-T0) + (GB/2)*(T^2 - T0^2) + (GC/3)*(T^3 - T0^3) + GD*((T-T0)/(T*T0)));
DH = DH0 + DH_2;
%TEMPERATURE THAT DH WILL EQUAL TO ZERO
syms t
f = R*(GA*(t-T0) + (GB/2)*(t^2 - T0^2) + (GC/3)*(t^3 - T0^3) + GD*((t-T0)/(t*T0)))+DH0==0;
T_ZERO = solve(f,t);

%SECTION4 : RESULTS
fprintf('the heat of reaction is: %d j\n and reaction at %d degree of centigrade has DH = 0 \n',DH,T_ZERO);
fprintf('Enter [a,b] for DH-T plot \n')
a = input('a: \n');
b = input('b: \n');
fplot(@(t) ((GA*(t-T0) + (GB/2)*(t^2 - T0^2) + (GC/3)*(t^3 - T0^3) + GD*((t-T0)/(t*T0)))+DH0),[a,b]);

