function trigon(varargin)
% TRIGON - Compute and show all trigonometric functions of a given angle
% 
% Syntax: 	trigon(alpha,deg)
%     
%    Inputs:
%          alpha - a scalar value of the angle (60 by default)
%          deg - 1 (default) if alpha is in degree or 0 if alpha is in radians
%    Outputs:
%          All trigonometric info and goniometric plot
% 
%     Example: 
%     trigon(45) will show 
% 
%                                  TrigFun 
%                                  ________
% 
%     Angle_Deg                    '45°'   
%     Arc_Rad                      '1/4*pi'
%     Quadrant                     'First' 
%     Radius                       [     1]
%     Circular_Sector              '1/8*pi'
%     Chord                        [0.7654]
%     Cosine_(cos)                 [0.7071]
%     Versed_Sine_(versin)         [0.2929]
%     Extrenal_Secant_(exsec)      [0.4142]
%     Secant_(sec)                 [1.4142]
%     Sine_(sin)                   [0.7071]
%     Versed_Cosine_(coversin)     [0.2929]
%     Extrenal_Cosecant_(excsc)    [0.4142]
%     Cosecant_(csc)               [1.4142]
%     Tangent_(tan)                [1.0000]
%     Cotangent_(cot)              [1.0000]
% 
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo.75@gmail.com
% 
% To cite this file, this would be an appropriate format:
% Cardillo G. (2024) Trigonometria
% http://www.mathworks.com/matlabcentral/fileexchange

p = inputParser;
addOptional(p,'angle',60,@(x) validateattributes(x,{'numeric'},{'scalar','real','finite','nonnan','nonempty'}));
addOptional(p,'deg',1, @(x) isnumeric(x) && isreal(x) && isfinite(x) && isscalar(x) && (x==0 || x==1));
parse(p,varargin{:});
angle=p.Results.angle; deg=p.Results.deg;
clear p varargin

close all
clc

if deg==1
    alphadeg=angle; 
    alpharad=angle*pi/180;
else
    alpharad=angle;
    alphadeg=angle*180/pi;
end

coseno=cos(alpharad);
seno=sin(alpharad);
if coseno>=0 && seno>=0
    quadrante='First'; x=1; y=1;
elseif coseno<0 && seno>=0
    quadrante='Second'; x=-1; y=1;
elseif coseno<0 && seno<0
    quadrante='Third'; x=-1; y=-1;
elseif coseno>=0 && seno<0
    quadrante='Fourth'; x=1; y=-1;
end
secante=sec(alpharad);
versin=x-coseno;
exsec=secante-x;
cosecante=csc(alpharad);
coversin=y-seno;
excsc=cosecante-y;
tng=tan(alpharad);
cotangente=cot(alpharad);

disp(cell2table({strcat(num2str(alphadeg),'°');...
    strcat(strtrim(rats(alpharad/pi)),'*pi');...
    quadrante;...
    1;...
    strcat(strtrim(rats(alpharad/pi/2)),'*pi');...
    2*sin(alpharad/2);...
    coseno;
    versin;...
    exsec;
    secante;...
    seno;...
    coversin;...
    excsc;
    cosecante;...
    tng;...
    cotangente;
    },...
    'RowNames',{'Angle_Deg';...
    'Arc_Rad';...
    'Quadrant';...
    'Radius';...
    'Circular_Sector';...
    'Chord';...
    'Cosine_(cos)';...
    'Versed_Sine_(versin)';...
    'Extrenal_Secant_(exsec)';...
    'Secant_(sec)';...
    'Sine_(sin)';...
    'Versed_Cosine_(coversin)';...
    'Extrenal_Cosecant_(excsc)';...
    'Cosecant_(csc)';...  
    'Tangent_(tan)';...    
    'Cotangent_(cot)';...
    },'VariableNames',{'TrigFun'}))

L=zeros(1,13); leglab=cell(size(L));

axis square
hold on
giro=0:pi/50:2*pi;
plot(cos(giro),sin(giro),'k',[-1 1],[0 0],'k',[0 0],[-1 1],'k') %goniometric circle
clear giro

theta=linspace(0,alpharad,52); J=1; k=-0.03;
fill([0 1 cos(theta) 0],[0 0 sin(theta) 0],[0.9655 1.0000 0],'EdgeColor','y','FaceAlpha',0.3);
L(J)=plot(cos(theta),sin(theta),'Color',[1 0.1034 0.7241],'Linewidth',2); leglab{J}='Arc';J=J+1;%arc
L(J)=plot([0 coseno],[0 seno],'Color',[0 0 0],'LineStyle','--','Linewidth',1);leglab{J}='Radius'; J=J+1; %radius
clear theta
L(J)=plot([coseno 1],[seno 0],'Color',[0 1 0],'Linewidth',2); leglab{J}='Chord'; J=J+1;%chord
L(J)=plot([0 secante],[k k],'Color',[0 1 1],'LineStyle','-','Linewidth',6);leglab{J}='Secant'; J=J+1; %secant
plot([0 coseno],[seno seno],'Color',[0 0 1],'LineStyle','--','Linewidth',1)
L(J)=plot([0 coseno],[0 0],'Color',[0 0 1],'Linewidth',2); leglab{J}='Cosine (cos)';J=J+1; %cosine
L(J)=plot([coseno coseno+versin],[0 0],'Color',[1 0 0],'Linewidth',2); leglab{J}='Versed Sine (versin)';J=J+1;%versin
L(J)=plot([x x+exsec],[0 0],'Color',[0 0.4138 0],'Linewidth',2); leglab{J}='External Secant (exsec)';J=J+1;%exsec
L(J)=plot([k k],[0 cosecante],'Color',[0.4138 0.1724 0],'LineStyle','-','Linewidth',6);leglab{J}='Cosecant'; J=J+1; %cosecant
plot([coseno coseno],[0 seno],'Color',[1 0.3686 0.0549],'LineStyle','--','Linewidth',1)
L(J)=plot([0 0],[0 seno],'Color',[1 0.3686 0.0549],'Linewidth',2); leglab{J}='Sine (sin)';J=J+1;%sine
L(J)=plot([0 0 ],[seno seno+coversin],'Color',[0.8621 1 0.7241],'Linewidth',2); leglab{J}='Versed Cosine (coversin)';J=J+1;%coversin
L(J)=plot([0 0],[y y+excsc],'Color',[1 0.5686 0.6863],'Linewidth',2); leglab{J}='External Cosecant (excsc)';J=J+1;%excsc
L(J)=plot([coseno secante],[seno 0],'Color',[0.5172 0.5172 1],'Linewidth',2); leglab{J}='Tangent (tan)';J=J+1;%tan
L(J)=plot([0 coseno],[cosecante seno],'Color',[0.5862 0.8276 0.3103],'Linewidth',2); leglab{J}='Cotangent (cot)';J=J+1;%cot
hold off
ax=[get(gca,'Xlim');get(gca,'Ylim')];
set(gca,'Ylim',[min(ax(:)) max(ax(:))])
set(gca,'Xlim',[min(ax(:)) max(ax(:))])
legend(L,leglab,'Location','NorthEastOutside');
title('Goniometric Circle','FontSize',16,'FontWeight','Bold')