objfunct = @obj_f;
x0 = [13,12,10,10];
lb = [0,0,0,0];
ub = [50,25,8,25];
options = optimoptions('ga','PlotFcn', @gaplotbestf, 'MaxGenerations',100,'PopulationSize',100);
nvars = 4;
rng default;
Aeq = [-1,0,0,1.5];
beq = [0];
A = [0,0,2,1;0,0,-0.5,-1;1,1,0,0];
B = [37;-8;60];
nonlcon = [];
[x,fval,exitFlag,output]=ga(objfunct, nvars,A,B,Aeq,beq,lb,ub,nonlcon,options)

sprintf('val : %f , %f, %f, %f', fval, x)
function [cost_f]=obj_f(x)
    cost_f = 1/(1+(20*x(1)+12*x(2)+10*x(3)+5*x(4)));
end