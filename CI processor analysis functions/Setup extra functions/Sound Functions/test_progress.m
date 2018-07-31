
fprintf('% 3d%%', 0);

for i=0:500
    
    
    
    if mod(i,10)==0
        fprintf('\b\b\b\b');
        fprintf('% 3d%%', round(i/500*100));
    end
    
    pause(.05)
    
end
fprintf('\n');

