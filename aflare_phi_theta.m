function [phi,theta]=aflare_phi_theta(X1,X2,y,R)
origine=X1(1);
capatx1=X1(length(X1));
capatx2=X2(length(X2));

%distantele intre 2 centre pentru cele 2 dimensiuni
distx1=(abs(X1(1))+abs(capatx1))/(R-1);
distx2=(abs(X2(1))+abs(capatx2))/(R-1);

%formare vectori C1 si C2
C1=[];
C2=[];
b1=(abs(X1(1))+abs(X1(length(X1))));
b2=(abs(X2(1))+abs(X2(length(X2))));
for i=1:R
    c1=X1(1)+(i-1)*distx1;
    C1=[C1 c1];
    c2=X2(1)+(i-1)*distx2;
    C2=[C2 c2];
end

%formare matrice phi
phi=[];
for i1=1:R
    p2=[];
    for i2=1:R
        ph=[];
        p=[];
        for k1=1:length(X1)
            for k2=1:length(X2)
                ph=exp(-(((X1(k1)-C1(i1))/b1)^2)-(((X2(k2)-C2(i2))/b2)^2));
                p=[p ph];
            end
        end
        p2=[p2;p];
    end
    phi=[phi;p2];
end
phi=phi';

%aflare theta
y2=reshape(y,length(y)^2,1);
theta=phi\y2;
end

