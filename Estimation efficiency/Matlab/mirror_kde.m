% Inputs:
%   X - n-by-d matrix of n d-dimensional data points
%   K - smoothing kernel (1d function handle)
%   h - bandwidth
%
% Outputs:
%   p - mirrored kernel density estimate (function handle)
%   

function p = mirror_kde(X, K, h)

  p = @(x) point_mirror_kde(x, X, K, h);

end

function p = point_mirror_kde(x, X, K, h)

  [n, d] = size(X);

  % all possible reflection indices
  fancyS = double(dec2base(0:3^d - 1,3)-'0');

  p = 0;
  parfor i=1:n % for each data point X(i,:)
    for k = 1:(3^d) % for each reflection of X(i,:)
      p = p + K_S_fun(x, X(i,:), fancyS(k,:), K, h);
    end
  end

  p = p/(n*h^d);

end

% a single reflection of a kernel at a single data point
function K_S = K_S_fun(x, y, S, K, h)

  % use a product kernel
  K_S = prod(arrayfun(@(xi, yi, Si) mirror_term(xi, yi, Si, K, h), x, y, S));

end

% 1 dimension of a single reflection of a kernel at a single data point
function term = mirror_term(xi, yi, Si, K, h)

  if Si == 0 % reflect y over 0
    term = K((xi + yi)/h);
  elseif Si == 1 % no reflection
    term = K((xi - yi)/h);
  else % reflect y over 1
    term = K((xi - 2 + yi)/h);
  end

end
