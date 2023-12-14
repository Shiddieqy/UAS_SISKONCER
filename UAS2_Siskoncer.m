objfunct = @obj_f;
x0 = [100, 100, 100];
lb = [0,0,0];
ub = [200,200,200];
options = optimoptions('ga','PlotFcn',@gaplotbestf, 'MaxGenerations',30,'PopulationSize',30);
nvars = 3;
rng default;
Aeq = [];
beq = [];
A = [];
B = [];
nonlcon = [];
[x,fval,exitFlag,output]=ga(objfunct, nvars,A,B,Aeq,beq,lb,ub,nonlcon,options);

sprintf('val : %f , %f, %f, %f', fval, x(1),x(2))
function [cost_f]=obj_f(x)
    sys = tf(1,[1,10,20]);
    kp = x(1);
    ki = x(2);
    kd = x(3);
    dt = 0.01;
    cont = pid(kp,ki);
    csys = feedback(cont*sys,1);
    
    t = [0:dt:5];
    [y,tc] = step(csys,t);
    e = 1-y;
    [u,tu] = step(feedback(cont,sys),t);
    A = 1;
    B = 1*0.01/5;
    C = 10000;
    cost_f = A*abs(max(y)-1)+B*sum(abs(u)*dt)+C*sum(rms(e)*dt);
end