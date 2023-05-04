% supplies=[15,25,10];
% demands=[5,15,15,15];
% cost_matrix=[10,2,20,11;12,7,9,20;4,14,16,18];
% A=[10,2,20,11;12,7,9,20;4,14,16,18];

% supplies=[100 125 75];
% demands=[120 80 75 25];
% cost_matrix=[3 3 4 1;4 2 4 2;1 5 3 2];
% A=[3 3 4 1;4 2 4 2;1 5 3 2];

supplies=[80 60 40 20];
demands=[60 60 30 40 10];
cost_matrix=[4 3 1 2 6;5 2 3 4 5; 3 5 6 3 2;2 4 4 5 3];
A=[4 3 1 2 6;5 2 3 4 5; 3 5 6 3 2;2 4 4 5 3];

supplies=[100 125 75];
demands=[120 80 75 25];
cost_matrix=[3 3 4 1;4 2 4 2;1 5 3 2];
A=[3 3 4 1;4 2 4 2;1 5 3 2];

% supplies=[15,25,10];
% demands=[5,15,15,15];
% cost_matrix=[2,2,2,2;2,2,2,2;2,2,2,2;];
% A=[2,2,2,2;2,2,2,2;2,2,2,2;];



max_val=max(max(cost_matrix)+1);
[num_rows,num_cols]=size(cost_matrix);
x_mat=zeros(num_rows,num_cols);
total_rows=num_rows;
total_cols=num_cols;
while total_rows>1 && total_cols>1
    disp(cost_matrix);
    [num_rows,num_cols]=size(cost_matrix);
    row_panelty=zeros(1,num_rows);
    col_panelty=zeros(1,num_cols);

%      temp matrix is to find panelty
    temp_cost_mat=cost_matrix;
    for i=1:num_rows
        [min_val,col]=min(temp_cost_mat(i,:));
        temp_cost_mat(i,col)=(max(max(cost_matrix))+1);
        [sec_min_val,sec_col]=min(temp_cost_mat(i,:));
        row_panelty(:,i)=sec_min_val-min_val;
    end
    
    temp_cost_mat=cost_matrix;
    
    for i=1:num_cols
        [min_val,row]=min(temp_cost_mat(:,i));
        temp_cost_mat(row,i)=(max(max(cost_matrix))+1);
        [sec_min_val,sec_row]=min(temp_cost_mat(:,i));
        col_panelty(:,i)=sec_min_val-min_val;
    end
    
    [row_max_val,row_max_index]=max(row_panelty);
    [col_max_val,col_max_index]=max(col_panelty);

    if(row_max_val==0 || col_max_val==0)
        break;
    end
%      first max Value then min cost then max_allocation
    if(row_max_val==col_max_val)
        [min_cost,min_col_index]=min(cost_matrix(row_max_index,:));

    elseif(row_max_val>col_max_val)
        [min_cost,min_col_index]=min(cost_matrix(row_max_index,:));
         min_row_index=row_max_index;
    else
        [min_cost,min_row_index]=min(cost_matrix(:,col_max_index));
        min_col_index=col_max_index;
    end
    


    % adjusting supplies and demand
     if(supplies(:,min_row_index)>demands(:,min_col_index))
        x_mat(min_row_index,min_col_index)=demands(:,min_col_index);
        supplies(:,min_row_index)=supplies(:,min_row_index)-demands(:,min_col_index);
        demands(:,min_col_index)=0;
        cost_matrix(:,min_col_index)=ones(num_rows,1)*(max_val);
        total_cols=total_cols-1;
     else
        x_mat(min_row_index,min_col_index)=supplies(:,min_row_index);
        demands(:,min_col_index)=demands(:,min_col_index)-supplies(:,min_row_index);
        supplies(:,min_row_index)=0;
        cost_matrix(min_row_index,:)=ones(1,num_cols)*(max_val);
        total_rows=total_rows-1;
     end
    % adjusting supplies and demand end
    
end
disp(x_mat);

while any(min(min(cost_matrix))<max_val)
    [min_row_index,min_col_index]=find(cost_matrix==min(min(cost_matrix)));
    min_row_index=min_row_index(1,1);
    min_col_index=min_col_index(1,1);
    if(supplies(:,min_row_index)>demands(:,min_col_index))
        x_mat(min_row_index,min_col_index)=demands(:,min_col_index);
        supplies(:,min_row_index)=supplies(:,min_row_index)-demands(:,min_col_index);
        demands(:,min_col_index)=0;
     else
        x_mat(min_row_index,min_col_index)=supplies(:,min_row_index);
        demands(:,min_col_index)=demands(:,min_col_index)-supplies(:,min_row_index);
        supplies(:,min_row_index)=0;
    end
    cost_matrix(min_row_index,min_col_index)=max_val;
end

disp('Initial Basic feasible solution - ');
disp(x_mat);
disp(sum(sum(x_mat.*A)));

