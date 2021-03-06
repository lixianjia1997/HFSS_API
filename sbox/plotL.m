function plotL(file, D, W, S, NT, replot)  
    close all
    [pathstr, name, ext] = fileparts(file);
    %disp([file '@path =' pathstr]);
    [f data]=SXPParse(file);       
    Z11 = s2z(data);    
    imZ11 = imag(Z11(1,1,:));
    imZ11 = imZ11(:);
    reZ11 = real(Z11(1,1,:));
    reZ11 = reZ11(:);
    imZ11n = imZ11;
    w = 2*pi*f';
    L = (imZ11n./w)*1e+9;
    Q = imZ11./reZ11;
    if(replot)
        plot(f/1e+9, L,'color','blue', 'LineWidth', 3);        
        grid on    
        %set(gca,'YLim',[0, 1]);
        %set(gca,'YTick',0:0.1:1);
        legend('L(nH)','Location','NorthWest');
        ylabel('Inductance (nH)');
        xlabel('Frequency (GHz)');   
        title(['Inductance of ' name]);
        if(~exist([pathstr '\L'],'dir'))
            mkdir([pathstr '\L']);
        end
        print(gcf,'-dpng', [pathstr '\L\L-' name '.png']);
        set(gca,'YLim',[0, 1]);
        set(gca,'YTick',0:0.05:1);
        print(gcf,'-dpng', [pathstr '\L\N-' name '.png']);
        figure     
        plot(f/1e+9, Q,'color','red', 'LineWidth', 3);
        hold on
        grid on    
        set(gca,'YLim',[0, 20]);
        set(gca,'YTick',0:1:20);
        legend('Q','Location','NorthWest');
        ylabel('Quality Factor');
        xlabel('Frequency (GHz)');   
        title(['Q of ' name]);
        if(~exist([pathstr '\Q'],'dir'))
            mkdir([pathstr '\Q']);
        end        
        print(gcf,'-dpng', [pathstr '\Q\Q-' name '.png']);        
        L1 = [f', L, Q];  
        if(~exist([pathstr '\csv'],'dir'))
            mkdir([pathstr '\csv']);
        end
        csvwrite([pathstr '\csv\' name '.csv'], L1 ); 
        %delete([pathstr '\summary.csv']);
    else
        disp('Skipping L/Q plot, collecting values for summary only');
    end
    Q5d8G = Q(99);
    Q10d6G = Q(272);
    Q24G = Q(409);
    L5d8G = L(99);
    L10d6G = L(272);
    L24G = L(409);
    array1 = [D,W,S, NT, L5d8G, Q5d8G, L10d6G, Q10d6G, L24G, Q24G];
    dlmwrite([pathstr '\summary.csv'], array1, '-append','delimiter',',');    
    close all
end