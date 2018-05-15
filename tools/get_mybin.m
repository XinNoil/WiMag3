function [i,j]=get_mybin(X,EDGES)
if X(1)<EDGES{1}(1)
    i=1;
elseif X(1)>EDGES{1}(end)
    i=length(EDGES{1})-1;
else
    for i=1:length(EDGES{1})
        if (EDGES{1}(i) <= X(1)) && (X(1) < EDGES{1}(i+1))
            break;
        end
    end
end
if X(2)<EDGES{2}(1)
    j=1;
elseif X(2)>EDGES{2}(end)
    j=length(EDGES{2})-1;
else
    for j=1:length(EDGES{2})
        if (EDGES{2}(j) <= X(2)) && (X(2) < EDGES{2}(j+1))
            break;
        end
    end
end