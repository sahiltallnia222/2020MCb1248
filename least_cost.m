clc
supplies=[100 125 75];
demands=[120 80 75 25];
A=[3 3 4 1;4 2 4 2;1 5 3 2];

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
tempA=A;
mv=max(max(A))+1;
X=zeros(size(A));
while size(A,1) && size(A,2)
    [row,col]=find(A==min(min(A)));
    row=row(1,:);
    col=col(1,:);
    [temp_row,temp_col]=find(tempA==min(min(tempA)));
    temp_row=temp_row(1,:);
    temp_col=temp_col(1,:);
    if(supplies(:,row)>demands(:,col))
        tempA(:,temp_col)=ones(size(tempA,1),1)*mv;
        A(:,col)=[];
        supplies(:,row)=supplies(:,row)-demands(:,col);
        X(temp_row,temp_col)=demands(:,col);
        demands(:,col)=[];
    else
        tempA(temp_row,:)=ones(1,size(tempA,2))*mv;
        A(row,:)=[];
        demands(:,col)=demands(:,col)-supplies(:,row);
        X(temp_row,temp_col)=supplies(:,row);
        supplies(:,row)=[];
    end
end


