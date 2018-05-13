function [intNum,intErr,Xv,Yv,X,Y,h] = CalcNumInt(epsilon,L,p,funxy,overlap)

    intAn=2*pi*(sqrt(L^2+epsilon^2)-epsilon);
    switch overlap
        case 0
            x=linspace(-L,L,2*p);
            y=linspace(-L,L,2*p);
        case 1
            x=linspace(-L,L,2*p+1);
            y=linspace(-L,L,2*p+1);
    end            
    h=x(2)-x(1);
    [X,Y]=ndgrid(x,y);
    Xv=X(:);
    Yv=Y(:);
    dS=L^2/p^2;
    intNum=dS*sum(funxy(Xv,Yv,epsilon));
    intErr=abs(intNum-intAn);
end

