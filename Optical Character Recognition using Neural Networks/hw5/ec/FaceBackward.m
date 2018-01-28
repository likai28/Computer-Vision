function [grad_W, grad_b] = FaceBackward(W, b, X, Y, act_h, act_a)


n=length(W);
[output, act_h, act_a] = FaceForward(W, b, X);
grad_W=cell(n,1);
grad_b=cell(n,1);

delta1=(output-Y);

for i=n:-1:1
    if(i==n)   % output layer
    grad_W{i}=delta1*(act_h{i-1})';
    grad_b{i}=delta1;
    delta2=W{i}'*delta1;
    
    elseif (i==1) % input layer
    grad_W{i}=delta2.*act_h{i}.*(1-act_h{i})*X';
    grad_b{i}=delta2.*act_h{i}.*(1-act_h{i});
    delta2=delta2.*act_h{i}.*(1-act_h{i});
    
    else
    grad_W{i}=delta2.*act_h{i}.*(1-act_h{i})*(act_h{i-1})';
    grad_b{i}=delta2.*act_h{i}.*(1-act_h{i});
    delta2=(W{i})'*(delta2.*act_h{i}.*(1-act_h{i}));
    end
            
end        
end
