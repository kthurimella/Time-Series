function bnet_time_series(samples)

% Graph Structure
N = samples;  % Number of nodes
dag = zeros(N,N); % Adjacency Matrix

% Create a read from all the samples and create a way to capture all
% of the different bacteria in the sample. 
for ii = 1:samples
    AA = randseq(ii);
    BB = randseq(ii + 1);
    dag(AA, BB) = 1;
    dag([AA, BB], W) = 1;
end

% Creating the Bayes net shell
discrete_nodes = 1:N;
node_sizes = 2*ones(1,N);  % The number of values node i can take on
bnet = mk_bnet(dag, node_sizes, 'names', [{'AA', 'BB'}], 'discrete', [1:samples]);


% Assume parameters are 0.5 between the parent and child node.
bnet.CPD{AA} = tabular_CPD(bnet, AA, [0.5, 0.5]);
bnet.CPD{BB} = tabular_CPD(bnet, BB, [0.5, 0.5]);


data = cell2num(samples);

end