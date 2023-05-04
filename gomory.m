clc
C=[5,2,0,0];
A=[2,2,1,0;3,1,0,1];
x_vars=["x1","x2","x3","x4","x5","x6","x7"];
b=[9;11];
B=[3,4];

[A_new,B_new,b_new,existFlag]=simplex_function(C,A,b,B);
k=0;
while true
    k=k+1;
    if k==10
        break;
    end
    disp([B_new' b_new A_new]);
    max_frac_index=0;
    max_frac=0;
    for i=1:size(A,1)
         cur_frac=mod(b_new(i,:),1);
         if(cur_frac>max_frac)
            max_frac=cur_frac;
            max_frac_index=i;
         end
    end
    if(max_frac<=1e-3)
        disp([B_new' b_new A_new]);
        break;
    end
    G=[];
    for i=1:size(A_new,2)
         G=[G, -mod(A_new(max_frac_index,i),1)];
    end
    b_new=[b_new;-max_frac];
    B_new=[B_new size(A_new,2)+1];
    A_new=[A_new;G];
    new_col=zeros(size(A_new,1),1);
    new_col(size(A_new,1),1)=1;
    A_new=[A_new,new_col];
    C=[C 0];
    [A_new,B_new,b_new,existFlag]=dual_simplex(C,A_new,b_new,B_new);
    if(~existFlag)
        disp("Solution does not exits.")
        break;
    end
end






