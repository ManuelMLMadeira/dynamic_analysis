function Animate(t)

global Body NBody
newplot; axis([-1 2 -0.1 2]); axis square;

for time = t
    
    cla(gca);
    hold on

    % Plot for each body
    for i = 1:NBody   
        plot([Body(i).pProx(1,time) Body(i).pDist(1,time)],...
             [Body(i).pProx(2,time) Body(i).pDist(2,time)],...
            '-o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');

    end

    % See time stamp
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',['Step: ' num2str(time)]);
    set(mTextBox,'Position',[140 320 60 30]);
    hold off; pause(0.01);

end

end