function [output, act_h, act_a] = FaceForward(W, b, X)

n=length(W);
act_h={};
act_a={};
input=X;

for i=1:n-1
    pre_activate=W{i}*input+b{i};
    act_a{i}=pre_activate;
    input=sigmf(pre_activate,[1,0]);
    act_h{i}=input;  
end
output=(W{n}*act_h{n-1})+(b{n});
end
