function [A,B,b,existFlag]=simplex_function(C,A,b,B)
    while true
        cur_cost=C(:,B);
        z_c=[];
        for i=1:size(A,2)
            z=cur_cost*A(:,i);
            z_c=[z_c (z-C(:,i))];
        end
        [M,col]=min(z_c);
        if(M>=0)
            existFlag=true;
            break;
        end
        minIndex=-1;
        minRatio=intmax;
        for i=1:size(A,1)
            ratio=b(i,:)/A(i,col);
            if(~(A(i,col)==0)&&(ratio>0) && ratio<minRatio)
                minIndex=i;
                minRatio=ratio;
            end
        end
        if(minIndex==-1)
            existFlag=0;
            break;
        end
        B(:,minIndex)=col;
        b(minIndex,:)=b(minIndex,:)/A(minIndex,col);
        A(minIndex,:)=A(minIndex,:)/A(minIndex,col);
        for i=1:size(A,1)
            if(i==minIndex)
                continue;
            end
            b(i,:)=b(i,:)-A(i,col)*b(minIndex,:);
            A(i,:)=A(i,:)-A(i,col)*A(minIndex,:);
        end
    end
end