function [intNum,intErr,Xv,Yv,X,Y] = CalcNumInt(epsilon,L,p,funxy)

    intAn=2*pi*(sqrt(L^2+epsilon^2)-epsilon);
    x=linspace(-L,L,2*p);
    y=linspace(-L,L,2*p);
    [X,Y]=ndgrid(x,y);
    Xv=X(:);
    Yv=Y(:);
    dS=L^2/p^2;
    intNum=dS*sum(funxy(Xv,Yv,epsilon));
    intErr=abs(intNum-intAn);
end

