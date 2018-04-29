% Estimates the Renyi-alpha Mutual Information of X and Y from respective
% joint samples Xs and Ys of equal length, using kernel kernel and bandwidth h
% Presently only works with univariate X and Y; this will be fixed

function I = MI_est(kernel,  Xs, Ys)
  n = size(Xs, 1);
  Xs=tiedrank(Xs)/(n+1);
    Ys=tiedrank(Ys)/(n+1);
   
    data = [Xs, Ys];
   dx=size(Xs,2);
   dy=size(Ys,2);
   d=dx+dy;
    n = size(data, 1)/2;

    % split data into 3 pieces (1 for each density to estimate)
    n3 = floor(n/3);
    dat1 = [Xs(1:n3,:)];
    dat2 = [Ys((n3 + 1):(2*n3),:)];
    dat3 = [data((2*n3 + 1):(3*n3),:)];
    
    sigma=sqrt(n3/(12*(n3+1)));
    h1=(4/(dx+2))^(1/(4+dx))*sigma/n3^(1/(dx+4));
    h2=(4/(dy+2))^(1/(4+dy))*sigma/n3^(1/(dy+4));
    h3=(4/(d+2))^(1/(4+d))*sigma/n3^(1/(d+4));

    % define KDEs of appropriate PDFs
    % p_XYZ = mirror_kde(X, kernel, h);
    p_X = mirror_kde(dat1, kernel, h1);
    p_Y = mirror_kde(dat2, kernel, h2);
    p_XY = mirror_kde(dat3, kernel, h3);

    I = 0;

    % Importance sampling with the log outside
    parfor i = (n + 1):(2*n)
      I = I + log(p_XY(data(i,:))/(p_X(Xs(i,:))*p_Y(Ys(i,:))));
    end

    I =I/n;

end
