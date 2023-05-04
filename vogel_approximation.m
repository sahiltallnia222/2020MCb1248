clc
% supplies=[100 125 75];
% demands=[120 80 75 25];
% A=[3 3 4 1;4 2 4 2;1 5 3 2];
A=[2,2,2;2,2,2;2,2,2];
supplies=[10,15,20];
demands=[13,18,14];
% A=[2,1,4;6,3,2;4,2,3];

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
row=size(A,1);
col=size(A,2);
max_val=max(max(A))+1;
X=zeros(size(A));
while ~(row==0 || col==0)
    disp(A);
    max_row_pan=intmin;
    row_no=-1;
    for i=1:size(A,1)
        [minval,index]=min(A(i,:));
        if(minval==max_val)
            continue;
        end
        temp_val=A(i,index);
        A(i,index)=max_val;
        [second_minval,second_index]=min(A(i,:));
        cur_pan=second_minval-minval;
        if(cur_pan>max_row_pan)
            max_row_pan=cur_pan;
            row_no=i;
        end
        A(i,index)=temp_val;
    end
    max_col_pan=intmin;
    col_no=-1;
    for i=1:size(A,2)
        [minval,index]=min(A(:,i));
        temp_val=A(index,i);
        A(index,i)=max_val;
        [second_minval,second_index]=min(A(:,i));
        cur_pan=second_minval-minval;
        if(cur_pan>max_row_pan)
            max_col_pan=cur_pan;
            col_no=i;
        end
        A(index,i)=temp_val;
    end
 
    if(max_row_pan>max_col_pan)
        [min_val,index]=min(A(row_no,:));
        pivot_row_no=row_no;
        pivot_col_no=index;
    else
        [min_val,index]=min(A(:,col_no));
        pivot_row_no=index;
        pivot_col_no=col_no;
    end
    if(supplies(:,pivot_row_no)>=demands(:,pivot_col_no))
        A(:,pivot_col_no)=ones(size(A,1),1)*max_val;
        supplies(:,pivot_row_no)=supplies(:,pivot_row_no)-demands(:,pivot_col_no);
        X(pivot_row_no,pivot_col_no)=demands(:,pivot_col_no);
        demands(:,pivot_col_no)=0;
        col=col-1;
    else
        A(pivot_row_no,:)=ones(1,size(A,2))*max_val;
        demands(:,pivot_col_no)=demands(:,pivot_col_no)-supplies(:,pivot_row_no);
        X(pivot_row_no,pivot_col_no)=supplies(:,pivot_row_no);
        supplies(:,pivot_row_no)=0;
        row=row-1;
    end
    disp(pivot_row_no);
    disp(pivot_col_no);
    disp(A);
    disp(X);
    disp(supplies);
    disp(demands);
end
