function  y3 = alg_srcmf_predict(Y,Sd,St,k,lambda_l,lambda_d,lambda_t,W)
    
    epsilon = 0.01;
    iter = 10;
    num_iter=1;
    Delta = 10^4;
    Objs = [];
    
    % initialize 
    [A,B] = initializer(Y,k);
    AA = initializer(Sd,k);
    BB  = initializer(St,k);
    
    J1=Obj_fun(W,Y,A,B,Sd,St,AA,BB,lambda_l,lambda_d,lambda_t);
    Objs=J1;
    
    H = W .* Y;
    lambda_d_eye_K = (lambda_l+lambda_d)*eye(k);
    lambda_t_eye_K = (lambda_l+lambda_t)*eye(k);
    
    while  num_iter<iter&&Delta>=epsilon
%      &&Delta>epsilon

        %update A
        d_up = H*B+lambda_d*AA;
        for a= 1:size(A,1)
            A(a,:) = d_up(a,:)/ (B'*diag(W(a,:))*B + lambda_d_eye_K);
        end
        
        %update B
        t_up = H'*A+lambda_t*BB;
        
        for b= 1:size(B,1)
            B(b,:) = t_up(b,:)/ (A'*diag(W(:,b))*A + lambda_t_eye_K);
        end
        
        %update AA
        AA = (2*Sd*AA+A)/(2*(AA')*AA+eye(k));
        
        %update BB
        BB = (2*St*BB+B)/(2*(BB')*BB+eye(k));
        
        J2=Obj_fun(W,Y,A,B,Sd,St,AA,BB,lambda_l,lambda_d,lambda_t);
        Delta = J1-J2;
        Objs=[Objs J2];
        J1 = J2;
        num_iter = num_iter + 1;
    end
    y3 = A*B';
end


function J = Obj_fun(W,Y,A,B,Sd,St,AA,BB,lambda_l,lambda_d,lambda_t)
    J = 0;
    J = J +norm(W.*(Y-A*B'),'fro')^2+lambda_l*(norm(A,'fro')^2+norm(B,'fro')^2);
    J = J + lambda_d*(norm(Sd-AA*AA','fro')^2 +norm(AA-A,'fro')^2 );
    J = J + lambda_t*(norm(St-BB*BB','fro')^2+norm(BB-B,'fro')^2 );
end
