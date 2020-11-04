function [A,B]=initializer(Y,K)
    [u,s,v] = svds(Y,K);
    A = u*(s^0.5);
    B = v*(s^0.5);

end