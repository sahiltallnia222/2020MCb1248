function [y_mat,cur_index,x_basic,feasible]=dual_simplex(C,y_mat,x_basic,cur_index)
    n=size(y_mat,2);
    m=size(y_mat,1);
    feasible=true;
    if(any(x_basic<0))
        feasible=false;
    end
    while ~feasible
         [M,row]=min(x_basic);
         if(M>=0)
             feasible=true;
             break;
         end
        z_c=C(:,cur_index)'.*y_mat;
        z_c=sum(z_c,1)-C;
        if(any(y_mat(row,:)<0))
            max_ratio=-intmax;
            index=-1;
            for k=1:n
                if y_mat(row,k)<0
                    ratio=z_c(1,k)/y_mat(row,k);
                    if(ratio>max_ratio)
                        index=k;
                        max_ratio=ratio;
                    end
                end
            end
            column_max=index;
            cur_index(:,row)=column_max;
            x_basic(row,:)=x_basic(row,:)/y_mat(row,column_max);
            y_mat(row,:)=y_mat(row,:)/y_mat(row,column_max);
            for j=1:m
                if(j==row)
                    continue;
                end
                x_basic(j,:)=x_basic(j,:)-x_basic(row,:)*y_mat(j,column_max);
                y_mat(j,:)=y_mat(j,:)-y_mat(row,:)*y_mat(j,column_max);
            end
        else
            feasible=false;
            break;
        end
    end
end








