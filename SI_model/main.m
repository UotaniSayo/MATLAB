tic
clear;
rng('shuffle')

%init var
initInfectRatio = 0.1;
pInfect = 0.1;
%j = 1;
%nodeSus = zeros(1,10);
A = zeros(10,10);
step = 500;

%load data
load('mail_A.mat');

%analyze data
node  = size(A,1);
state = ones(1,node);

allState = zeros(step, node);

%random initial state
for k = 1:node
    if rand() <= initInfectRatio
        A(k,:) = A(k,:)+1i*real(A(k,:));
    else
        state(k) = 0;
        %nodeSus(j)=k;
        %j = j+1;
    end
end

allState(1,:) = state;

%start
%while sum(state) < node
for m = 2:step
    %indexSus = 1;
    %nodeTmp = nodeSus;
    for k = 1:node
        %if sum(real(A(k,:))) > 0
        if state(k) == 0
            cntInfect = sum(imag(A(:,k)));
            if rand() >= (1-pInfect)^cntInfect
                state(k) = 1;
                A(k,:) = A(k,:)+1i*real(A(k,:));
                %delete infected node from nodeSus
                %nodeSus(indexSus) = [];
            %else
                %indexSus = indexSus+1;
            end
        end
    end
    allState(m,:) = state;
end

disp(sum(state));
toc

%END
