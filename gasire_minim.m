function [index]=gasire_minim(m1,m2)
v1=[];
v1=(m1.^2).*(m2.^2);
min=v1(1);
index=1;
for i=1:length(v1)
    if(v1(i)<min)
        min=v1(i);
        index=i;
    end
end