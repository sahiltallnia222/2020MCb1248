clc
supplies=[10,15,20];
demands=[13,18,14];
A=[2,1,4;6,3,2;4,2,3];

if(sum(supplies)>sum(demands))
    diff=sum(supplies)-sum(demands);
    new_col=zeros(size(A,1),1);
    A=[A new_col];
    demands=[demands diff];
end
if(sum(supplies)<sum(demands))
    diff=sum(demands)-sum(supplies);
    new_row=zeros(1,size(A,2));
    A=[A;new_row];
    supplies=[supplies diff];
end
X=zeros(size(A));
row=1;
col=1;
while row<=size(A,1) && col<=size(A,2)
    if(supplies(:,row)>demands(:,col))
        X(row,col)=demands(:,col);
        supplies(:,row)=supplies(:,row)-demands(:,col);
        col=col+1;
    else
       X(row,col)=supplies(:,row);
       demands(:,col)=demands(:,col)-supplies(:,row);
       row=row+1;         
    end
end


