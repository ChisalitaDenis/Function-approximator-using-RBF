clear all
load('proj_fit_19.mat')
%% citire date identificare si validare
x1=id.X(1);
x2=id.X(2);
y_id=id.Y;
dim=id.dims;
X1_id=x1{1};
X2_id=x2{1};
x1_val=val.X(1);
x2_val=val.X(2);
y_val=val.Y;
dim_val=val.dims;
X1_val=x1_val{1};
X2_val=x2_val{1};

%% initializare vectori pentru R,erori si iesirile aproximate
Rs=[];
Mses_id=[];
Mses_val=[];
ys_id=[];
ys_val=[];

%% aflare phi si theta folosind functia aflare_phi_theta 
for R=2:30
    %pentru identificare
    [phi_id,theta_id]=aflare_phi_theta(X1_id,X2_id,y_id,R);
    
    %pentru validare
    [phi_val,theta_val]=aflare_phi_theta(X1_val,X2_val,y_val,R);
    %aproximare pentru datele de validare
    y_verificare_val=phi_val*theta_id;
    ys_val=[ys_val y_verificare_val];
    y2=reshape(y_val,length(y_val)^2,1);
    e=y2-y_verificare_val;
    mse_val=mean(e.^2);
    Mses_val=[Mses_val mse_val];
    %aproximare pentru datele de identificare
    y_verificare_id=phi_id*theta_val;
    ys_id=[ys_id y_verificare_id];
    y3=reshape(y_id,length(y_id)^2,1);
    e2=y3-y_verificare_id;
    mse_id=mean(e2.^2);
    Mses_id=[Mses_id mse_id];
    
   Rs=[Rs R];
end

%% gasirea index-ului celor mai mici erori pentru identificare,cat si pentru validare folosind functia gasire_minim
index_minMSE=gasire_minim(Mses_id,Mses_val);

%% selectarea datelor pentru index-ul gasit 
R=Rs(index_minMSE);
mse_val=Mses_val(index_minMSE);
mse_id=Mses_id(index_minMSE);

%pentru validare
y_verificare_val1=ys_val(:,index_minMSE);
y_verificare_val=reshape(y_verificare_val1,length(y_val),length(y_val));
%afisare y validare si y validare aproximat
figure(1)
axis ([X1_val(1) X1_val(length(X1_val)) X2_val(1) X2_val(length(X2_val)) y_val(1) y_val(length(y_val))]);
surf(X1_val,X2_val,y_val);
title('y validare');
figure(2)
surf(X1_val,X2_val,y_verificare_val);
title(['Validare: Mse=',num2str(mse_val),' , R=',num2str(R)]);

%pentru identificare
y_verificare_id1=ys_id(:,index_minMSE);
y_verificare_id=reshape(y_verificare_id1,length(y_id),length(y_id));
%afisare y identificare si y identificare aproximat
figure(3)
surf(X1_id,X2_id,y_id);
title('y identificare');
figure(4)
surf(X1_id,X2_id,y_verificare_id);
title(['Identificare: Mse=',num2str(mse_id),' , R=',num2str(R)]);

    