function i=get_mybin1(X,EDGES)
if X<EDGES(1)
    i=1;
elseif X>EDGES(end)
    i=length(EDGES)-1;
else
    for i=1:length(EDGES)
        if (EDGES(i) <= X) && (X <= EDGES(i+1))
            break;
        end
    end
end