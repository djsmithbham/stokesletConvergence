% test quadrature of 1/sqrt(r^2+ep^2) over a circle of radius L

clear all;
close all;

epsilon=0.000001;
L=2;


funr = @(x,y) sqrt(x.^2+y.^2);
domainFunr = @(r) r<=L;
domainFunxy = @(x,y) domainFunr(funr(x,y));
fun=@(r,epsilon) 1./sqrt(r.^2+epsilon^2).*domainFunr(r);
funxy = @(x,y,epsilon) fun(funr(x,y),epsilon);

jj=2:6;
kk=2:7;
pp=2.^jj;
epsilon=10.^(-kk);
for j=1:length(jj)
    for k=1:length(kk)
        [intNum(j,k),intErr(j,k),Xv{j},Yv{j},X{j},Y{j}] = CalcNumInt(epsilon(k),L,pp(j),funxy);
    end
end

figure(1);clf;hold on;
for k=1:length(kk)
    plot(jj,log2(intErr(:,k)));
end
xlabel('log2(Q)');
ylabel('log2(Err)');
gradient=(log2(intErr(end,end))-log2(intErr(1,end)))/(jj(end)-jj(1));
title(['rate of convergence with hq = ' num2str(gradient) ' for epsilon = ' num2str(epsilon(end))]);

figure(2);clf;
plot(Xv{4}./domainFunxy(Xv{4},Yv{4}),Yv{4}./domainFunxy(Xv{4},Yv{4}),'.');
axis equal

figure(3);clf;
mesh(X{5},Y{5},funxy(X{5},Y{5},epsilon(1))./domainFunxy(X{5},Y{5}))


