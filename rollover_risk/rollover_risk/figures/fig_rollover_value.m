function fig_rollover_value(b_range,V_R_max_grid,pol_grid,q_EG_grid,q_crisis_grid,optfig)
if optfig.plotfig == 1
    
    [fontname,dimension,lw,folder,color,style,marker,markersize,fontsize_tit,~,fontsize_lab,fontsize_leg] = fn_optfig(optfig);
    
    f1 = figure('Units','inches','OuterPosition',[0 0 8 5]);
    
    plot(b_range,V_R_max_grid,'Color',color{1},'LineWidth',3,'LineStyle',style{1});
    xlabel('$b_1$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('Repayment Value $V^R (b_1)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$V^R (b_1)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f2 = figure('Units','inches','OuterPosition',[0 0 8 5]);
    
    plot(b_range,pol_grid,'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold off;
    xlabel('$b_1$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$b_2^*$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$b_2$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    f3 = figure('Units','inches','OuterPosition',[0 0 8 5]);
    
    plot(b_range,q_EG_grid,'Color',color{1},'LineWidth',3,'LineStyle',style{1}); hold on;
    plot(b_range,q_crisis_grid,'Color',color{2},'LineWidth',3,'LineStyle',style{2}); hold off;
    xlabel('$b_1$','interpreter','latex','FontSize',fontsize_lab,'FontName',fontname);
    title('$q(b_1,b_2)$','interpreter','latex','FontSize',fontsize_tit,'FontName',fontname);
    grid; axis tight; box off;
    
    legendCell = {'$q_{EG}(b_2)$', '$q_{CK}(b_2)$'};
    legend(legendCell,'interpreter','latex','FontSize',18,'FontName',fontname,'Location','Best')
    legend boxoff
    
    
    name = 'repay_val';
    print(f1,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])
    
    name = 'pol';
    print(f2,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])
    
    name = 'q_EG_crisis';
    print(f3,'-depsc','-painters','-noui','-r600', [folder,name,'.eps'])
    
    if optfig.close == 1; close(who('f')); end
    
end

end