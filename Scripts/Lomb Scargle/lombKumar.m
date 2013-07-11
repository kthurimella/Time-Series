% Written by Kumar Thurimella

function spectralPower = lomb(t, y, frequency)
        % Find a spectral power of lomb-scargle periodogram
        % pre-allocate constants
        nfrequency = length(frequency);
        fmax = frequency(nfrequency);
        fmin = frequency(1);
        spectralPower = zeros(nfrequency, 1);
        
        % this specific pre-allocation makes the code run quickly
        f4pi = frequency * 4 .* pi;
        
        % pre-define constants based on length of input
        n = length(y);
        cosarg= zeros(n, 1);
        sinarg = zeros(n, 1);
        argu = zeros(n, 1);

        % variance
        var = cov(y); 

        % subtract mean
        yn = y - mean(y);

        % do Lomb loops defined by frequency
        for ii = 1:nfrequency;
            
            % calculate the orthogonal sums of sin and cos
            sinsum = sum(sin(f4pi(ii)*t));
            cossum = sum(cos(f4pi(ii)*t));
            
            % solve for the time lag tau using arc tangent
            tau = atan2(sinsum, cossum);
            argu = (pi * 2.) * frequency(ii) * (t - tau);
            
            % fit the sin arguments based on the formula of lomb-scargle
            sinarg = sin(argu);
            sfi = sum(yn .* sinarg);
            sinnorm = sum(sinarg .* sinarg);
            
            % fit the cos arguments based on the formula of lomb-scargle
            cosarg = cos(argu);
            cfi = sum(yn .* cosarg);
            cosnorm = sum(cosarg .* cosarg);
            
            % calculate the spectral power over the frequency loops
            spectralPower(ii) = (cfi * cfi/cosnorm+sfi*sfi/sinnorm)/2*var;
        end
end
