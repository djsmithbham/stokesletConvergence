% test quadrature of 1/sqrt(r^2+ep^2) over a circle of radius L

clear all;
close all;

%

%set(groot,'defaultAxesColorOrder',[0 0 0],...
%      'defaultAxesLineStyleOrder','-|--|:')

epsilon=0.01;
L=1;
wd=4.5;ht=5;
fs=9;fn='times';

funr = @(x,y) sqrt(x.^2+y.^2);
domainFunr = @(r) r<=L;
domainFunxy = @(x,y) domainFunr(funr(x,y));
fun=@(r,epsilon) 1./sqrt(r.^2+epsilon^2).*domainFunr(r);
funxy = @(x,y,epsilon) fun(funr(x,y),epsilon);

jj=2:10;
kk=3:6;
pp=2.^jj;
epsilon=10.^(-kk);
overlap=0;
for j=1:length(jj)
    for k=1:length(kk)
        [intNum(j,k),intErr(j,k),Xv{j},Yv{j},X{j},Y{j},h(j)] = CalcNumInt(epsilon(k),L,pp(j),funxy,overlap);
    end
end

figure(3);clf;
for k=1:4
    loglog(h,intErr(:,k));
    hold on;
    leg{k}=['\epsilon=' num2str(epsilon(k))];
end
legend(leg,'location','southeast','box','off');
hx=xlabel('\(h_q\)','interpreter','latex');
hy=ylabel('\(Err\)','interpreter','latex');
set(hx,'fontsize',fs,'fontname',fn);
set(hy,'fontsize',fs,'fontname',fn);
set(gca,'fontsize',fs,'fontname',fn);
box on;
set(gca,'tickdir','out');
set(3,'paperunits','centimeters');
set(3,'papersize',[1.75*wd 1.5*ht]);
set(3,'paperposition',[0 0 1.75*wd 1.5*ht]);
print(3,'-dpdf','-r150','nonOverlapConv.pdf');
gradient=(log2(intErr(end,end))-log2(intErr(1,end)))/(jj(end)-jj(1));
title(['rate of convergence with hq = ' num2str(gradient) ' for epsilon = ' num2str(epsilon(end))]);
%%

figure(2);clf;hold on;
plot(Xv{2}./domainFunxy(Xv{2},Yv{2}),Yv{2}./domainFunxy(Xv{2},Yv{2}),'.');
plot(0,0,'ro');
axis equal
set(2,'paperunits','centimeters');
set(2,'papersize',[wd ht]);
set(2,'paperposition',[0 0 wd ht]);
axis equal;axis([-1 1 -1 1]);
print(2,'-dpdf','-r150','nonOverlapPlot.pdf');

%%

overlap=1;
for j=1:length(jj)
    for k=1:length(kk)
        [intNum(j,k),intErr(j,k),Xv{j},Yv{j},X{j},Y{j},h(j)] = CalcNumInt(epsilon(k),L,pp(j),funxy,overlap);
    end
end

figure(3);clf;
for k=1:4
    loglog(h,intErr(:,k));
    hold on;
    leg{k}=['\epsilon=' num2str(epsilon(k))];
end
legend(leg,'location','southeast','box','off');
hx=xlabel('\(h_q\)','interpreter','latex');
hy=ylabel('\(Err\)','interpreter','latex');
set(hx,'fontsize',fs,'fontname',fn);
set(hy,'fontsize',fs,'fontname',fn);
set(gca,'fontsize',fs,'fontname',fn);
box on;
set(gca,'tickdir','out');
set(3,'paperunits','centimeters');
set(3,'papersize',[1.75*wd 1.5*ht]);
set(3,'paperposition',[0 0 1.75*wd 1.5*ht]);
print(3,'-dpdf','-r150','overlapConv.pdf');
gradient=(log2(intErr(end,1))-log2(intErr(1,1)))/(jj(end)-jj(1));
title(['rate of convergence with hq = ' num2str(gradient) ' for epsilon = ' num2str(epsilon(end))]);

figure(2);clf;hold on;
plot(Xv{2}./domainFunxy(Xv{2},Yv{2}),Yv{2}./domainFunxy(Xv{2},Yv{2}),'.');
plot(0,0,'ro');
axis equal
set(2,'paperunits','centimeters');
set(2,'papersize',[wd ht]);
set(2,'paperposition',[0 0 wd ht]);
axis equal;axis([-1 1 -1 1]);
print(2,'-dpdf','-r150','overlapPlot.pdf');

figure(1);clf;
mesh(X{5},Y{5},funxy(X{5},Y{5},epsilon(1))./domainFunxy(X{5},Y{5}))
set(1,'paperunits','centimeters');
set(1,'papersize',[wd ht]);
set(1,'paperposition',[0 0 wd ht]);
print(1,'-dpdf','-r150','kernelPlot.pdf');

