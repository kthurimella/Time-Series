% Graph Structure
N = 4;  % Number of nodes
dag = zeros(N,N); 
C = 1; S = 2; R = 3; W = 4;
dag(C,[R S]) = 1;
dag(R, W) = 1;
dag(S, W) = 1;

% Creating the Bayes net shell
discrete_nodes = 1:N;
node_sizes = 2*ones(1,N);  % The number of values node i can take on
bnet = mk_bnet(dag, node_sizes, 'names', [{'C', 'S', 'R', 'W'}], 'discrete', [1:4]);

% Parameters
bnet.CPD{C} = tabular_CPD(bnet, C, [0.5, 0.5]);
bnet.CPD{R} = tabular_CPD(bnet, R, [0.8, 0.2, 0.2, 0.8]);
bnet.CPD{S} = tabular_CPD(bnet, S, [0.5, 0.9, 0.5, 0.1]);
bnet.CPD{W} = tabular_CPD(bnet, W, [1, 0.1, 0.1, 0.01, 0, 0.9, 0.9, 0.99]);

% Generate some data from the sprinkler network, randomize the parameters
nsamples = 281; % # of samples
samples = cell(N, nsamples);
seed = 0; rand('state', seed);  % Fix the seed to make it repeatable.

for i=1:nsamples
samples(:,i) = sample_bnet(bnet); % cell array sample{j,i}: the value of
% the j'th node in case i
end

data = cell2num(samples);