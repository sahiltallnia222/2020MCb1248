clc
% A=[5 3 2 8;7 9 2 6;6 4 5 7;5 7 7 8];
% AC=[5 3 2 8;7 9 2 6;6 4 5 7;5 7 7 8];
A=[85 75 65 125 75;90 78 66 132 78;75 66 57 114 69;80 72 60 120 72;76 64 56 112 68];
AC=[85 75 65 125 75;90 78 66 132 78;75 66 57 114 69;80 72 60 120 72;76 64 56 112 68];
[n,m]=size(A);
for i=1:n
    [M,I]=min(A(i,:));
    A(i,:)=A(i,:)-M;
end
for i=1:m
    [M,I]=min(A(:,i));
    A(:,i)=A(:,i)-M;
end
max_val=max(max(A))*1000+1;
x=zeros(size(A));
[r,c]=find(x==1);
while size(r,1)<n
    tempA=A;
    x=zeros(size(A));
    for i=1:n
        [row,col]=find(tempA(i,:)==0);
        if(isempty(row))
            continue;
        end
        if(size(row,2)>1)
            continue;
        else
            [p,q]=find(tempA(row(1,:),:)==0);
            [p_1,q_1]=find(tempA(row(1,:),:)==max_val);
            [r,s]=find(tempA(:,col(1,:))==0);
            [r_1,s_1]=find(tempA(:,col(1,:))==max_val);
            p=[p,p_1];
            r=[r;r_1];
            if(size(p,2)>1)
                tempA(row(1,:),:)=tempA(row(1,:),:)+ones(1,m)*max_val;
            end
            if(size(r,1)>1)
               tempA(:,col(1,:))=tempA(:,col(1,:))+ones(n,1)*max_val;
            end
            x(i,col(1,:))=1;
        end
    end
    for i=1:m
        [row,col]=find(tempA(:,i)==0);
        if(isempty(row))
            continue;
        end
        if(size(row,2)>1)
            continue;
        else
            [p,q]=find(tempA(row(1,:),:)==0);
            [p_1,q_1]=find(tempA(row(1,:),:)==max_val);
            [r,s]=find(tempA(:,col(1,:))==0);
            [r_1,s_1]=find(tempA(:,col(1,:))==max_val);
            p=[p,p_1];
            r=[r;r_1];
            if(size(p,2)>1)
                tempA(row(1,:),:)=tempA(row(1,:),:)+ones(1,m)*max_val;
            end
            if(size(r,1)>1)
               tempA(:,col(1,:))=tempA(:,col(1,:))+ones(n,1)*max_val;
            end
            x(row(1,:),i)=1;
        end
    end
    [M,Index]=min(min(tempA));
    for i=1:n
        for j=1:m
        if(tempA(i,j)==max_val)
            continue;
        elseif (tempA(i,j)>=2*max_val || tempA(i,j)<max_val)
            A(i,j)=A(i,j)-M;
        else
            continue;
        end
        end
    end
    
    disp(tempA);
    [zeros_row,zeros_col]=find(tempA==0);
    [r,c]=find(x==1);
end
sum(sum(AC.*x))