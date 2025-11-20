function trigon(varargin)
%TRIGON Compute and display trigonometric functions for a given angle.
%
%   Syntax
%   ------
%   trigon()
%   trigon(angle)
%   trigon(angle, deg)
%
%   Description
%   -----------
%   TRIGON computes the main trigonometric and “goniometric” quantities
%   associated with a given angle and displays:
%     - a summary table of trigonometric values and geometric quantities;
%     - a goniometric circle plot showing radius, chord, sine, cosine,
%       versed functions, secant/cosecant, tangent, and cotangent.
%
%   By default the angle is interpreted in degrees. You can switch to
%   radians by setting the second input argument to 0.
%
%   For a set of standard angles in degrees (e.g. 0°, 30°, 45°, 60°, 90°,
%   ..., 330°), TRIGON also shows exact symbolic-like forms such as:
%     cos(30°) = √3/2
%     sin(45°) = √2/2
%     tan(60°) = √3
%   The table displays both the exact form and a numeric approximation,
%   except when the exact value is 0, 1 or -1, which are shown without
%   any numeric suffix.
%
%   Inputs
%   ------
%   angle : (optional) Scalar numeric value of the angle.
%           Default: 60
%           If deg = 1, angle is interpreted in degrees.
%           If deg = 0, angle is interpreted in radians.
%
%   deg   : (optional) Scalar logical-like flag (0 or 1).
%           1  -> angle is in degrees (default)
%           0  -> angle is in radians
%
%   Outputs
%   -------
%   This function does not return any output arguments. It:
%     - prints a table with trigonometric values and geometric quantities;
%     - produces a goniometric circle plot in the current figure.
%
%   Example
%   -------
%   trigon(45)
%     computes all trigonometric quantities for 45 degrees and displays:
%
%       Angle_Deg                      '45°'
%       Arc_Rad                        '1/4*pi'
%       Quadrant                       'First'
%       Radius                         [     1]
%       Circular_Sector                '1/8*pi'
%       Chord                          '√2 (≈ 1.4142)'
%       Cosine_(cos)                   '√2/2 (≈ 0.7071)'
%       Versed_Sine_(versin)           [0.2929]
%       External_Secant_(exsec)        [0.4142]
%       Secant_(sec)                   '√2 (≈ 1.4142)'
%       Sine_(sin)                     '√2/2 (≈ 0.7071)'
%       Versed_Cosine_(coversin)       [0.2929]
%       External_Cosecant_(excsc)      [0.4142]
%       Cosecant_(csc)                 '√2 (≈ 1.4142)'
%       Tangent_(tan)                  '1'
%       Cotangent_(cot)                '1'
%
%   Notes
%   -----
%   - The radius of the goniometric circle is fixed to 1.
%   - The quadrant label is determined by the signs of sine and cosine.
%   - For recognised special angles, exact forms with radicals (√2, √3,
%     √2/2, √3/2, etc.) are shown together with numeric approximations,
%     except for the exact values 0, 1, and -1, which are shown alone.
%   - For angles at singularities (e.g., 90°, 270°), some values become
%     infinite. For recognised special angles, these are shown as 'Inf' or
%     '-Inf' without numeric approximation.
%   - The plot window is clamped to [-2.5, 2.5] on both axes so that the
%     unit circle remains visible even when secant/cosecant/tangent are
%     very large.
%
%   Citation
%   --------
%   If you use this function in academic or technical work, please cite:
%
%     Cardillo G. (2024)
%     "Trigonometria".
%     Available from GitHub:
%     https://github.com/dnafinder/trigonometria
%
%   Metadata
%   --------
%   Author : Giuseppe Cardillo
%   Email  : giuseppe.cardillo.75@gmail.com
%   GitHub : https://github.com/dnafinder
%   Created: 2024-01-01
%   Updated: 2025-11-20
%   Version: 2.4.0
%
%   License
%   -------
%   This function is distributed under the MIT License.
%   See the LICENSE file in the GitHub repository for details.
%

% -------------------------------------------------------------------------
% Input parsing
% -------------------------------------------------------------------------
p = inputParser;
p.FunctionName = mfilename;

addOptional(p,'angle',60, @(x) validateattributes(x,{'numeric'}, ...
    {'scalar','real','finite','nonnan','nonempty'}, mfilename,'angle',1));

addOptional(p,'deg',1, @(x) isnumeric(x) && isscalar(x) && ...
    isfinite(x) && isreal(x) && any(x == [0 1]));

parse(p,varargin{:});
angle = p.Results.angle;
deg   = p.Results.deg;
clear p varargin

% -------------------------------------------------------------------------
% Angle normalization and basic trig values
% -------------------------------------------------------------------------
if deg == 1
    alphadeg = angle;
    alpharad = angle * pi/180;
else
    alpharad = angle;
    alphadeg = angle * 180/pi;
end

coseno = cos(alpharad);
seno   = sin(alpharad);

% Determine quadrant and sign anchors for “external” functions
if coseno >= 0 && seno >= 0
    quadrante = 'First';
    xAnchor   = 1;
    yAnchor   = 1;
elseif coseno < 0 && seno >= 0
    quadrante = 'Second';
    xAnchor   = -1;
    yAnchor   = 1;
elseif coseno < 0 && seno < 0
    quadrante = 'Third';
    xAnchor   = -1;
    yAnchor   = -1;
else % coseno >= 0 && seno < 0
    quadrante = 'Fourth';
    xAnchor   = 1;
    yAnchor   = -1;
end

% Trigonometric and derived quantities
secante    = sec(alpharad);
versin     = xAnchor - coseno;
exsec      = secante - xAnchor;
cosecante  = csc(alpharad);
coversin   = yAnchor - seno;
excsc      = cosecante - yAnchor;
tng        = tan(alpharad);
cotangente = cot(alpharad);

% Chord (geometric)
chordNum      = 2 * sin(alpharad/2);
chordExactStr = chordExact(alphadeg);
chordVal      = formatExactNumeric(chordExactStr, chordNum);

% -------------------------------------------------------------------------
% Exact forms for special angles (cos, sin, tan, sec, csc, cot)
% -------------------------------------------------------------------------
cosExact = trigExact('cos', alphadeg);
sinExact = trigExact('sin', alphadeg);
tanExact = trigExact('tan', alphadeg);
secExact = trigExact('sec', alphadeg);
cscExact = trigExact('csc', alphadeg);
cotExact = trigExact('cot', alphadeg);

cosVal = formatExactNumeric(cosExact, coseno);
sinVal = formatExactNumeric(sinExact, seno);
tanVal = formatExactNumeric(tanExact, tng);
secVal = formatExactNumeric(secExact, secante);
cscVal = formatExactNumeric(cscExact, cosecante);
cotVal = formatExactNumeric(cotExact, cotangente);

% -------------------------------------------------------------------------
% Textual output: summary table
% -------------------------------------------------------------------------
angleDegStr = strcat(num2str(alphadeg),'°');
arcRadStr   = strcat(strtrim(rats(alpharad/pi)),'*pi');
sectorStr   = strcat(strtrim(rats(alpharad/pi/2)),'*pi');

rowNames = { ...
    'Angle_Deg'; ...
    'Arc_Rad'; ...
    'Quadrant'; ...
    'Radius'; ...
    'Circular_Sector'; ...
    'Chord'; ...
    'Cosine_(cos)'; ...
    'Versed_Sine_(versin)'; ...
    'External_Secant_(exsec)'; ...
    'Secant_(sec)'; ...
    'Sine_(sin)'; ...
    'Versed_Cosine_(coversin)'; ...
    'External_Cosecant_(excsc)'; ...
    'Cosecant_(csc)'; ...
    'Tangent_(tan)'; ...
    'Cotangent_(cot)'};

values = { ...
    angleDegStr; ...
    arcRadStr; ...
    quadrante; ...
    1; ...
    sectorStr; ...
    chordVal; ...
    cosVal; ...
    versin; ...
    exsec; ...
    secVal; ...
    sinVal; ...
    coversin; ...
    excsc; ...
    cscVal; ...
    tanVal; ...
    cotVal};

T = cell2table(values, 'RowNames', rowNames, 'VariableNames', {'TrigFun'});
disp(T)

% -------------------------------------------------------------------------
% Graphical output: goniometric circle plot
% -------------------------------------------------------------------------
L      = zeros(1,13);       % preallocate handles for legend entries
leglab = cell(size(L));     % legend labels

axis square
hold on
grid on
box on

% Goniometric circle and axes
thetaCircle = linspace(0,2*pi,101);
plot(cos(thetaCircle), sin(thetaCircle), 'k', ...
     [-1 1], [0 0], 'k', ...
     [0 0], [-1 1], 'k');          % circle and main axes
clear thetaCircle

% Small vertical offset used to draw secant/cosecant segments
kOffset = -0.03;

% Arc and radius
thetaArc = linspace(0, alpharad, 52);
J = 1;

% Circular sector fill
fill([0 1 cos(thetaArc) 0],[0 0 sin(thetaArc) 0], ...
     [0.9655 1.0000 0], 'EdgeColor','y','FaceAlpha',0.3);

% Arc
L(J) = plot(cos(thetaArc), sin(thetaArc), ...
    'Color',[1 0.1034 0.7241],'LineWidth',2);
leglab{J} = 'Arc'; J = J+1;

% Radius
L(J) = plot([0 coseno],[0 seno], ...
    'Color',[0 0 0],'LineStyle','--','LineWidth',1);
leglab{J} = 'Radius'; J = J+1;
clear thetaArc

% Chord
L(J) = plot([coseno 1],[seno 0], ...
    'Color',[0 1 0],'LineWidth',2);
leglab{J} = 'Chord'; J = J+1;

% Secant (horizontal segment)
L(J) = plot([0 secante],[kOffset kOffset], ...
    'Color',[0 1 1],'LineStyle','-','LineWidth',6);
leglab{J} = 'Secant'; J = J+1;

% Cosine
plot([0 coseno],[seno seno], ...
    'Color',[0 0 1],'LineStyle','--','LineWidth',1);
L(J) = plot([0 coseno],[0 0], ...
    'Color',[0 0 1],'LineWidth',2);
leglab{J} = 'Cosine (cos)'; J = J+1;

% Versed sine
L(J) = plot([coseno coseno+versin],[0 0], ...
    'Color',[1 0 0],'LineWidth',2);
leglab{J} = 'Versed Sine (versin)'; J = J+1;

% External secant
L(J) = plot([xAnchor xAnchor+exsec],[0 0], ...
    'Color',[0 0.4138 0],'LineWidth',2);
leglab{J} = 'External Secant (exsec)'; J = J+1;

% Cosecant (vertical segment)
L(J) = plot([kOffset kOffset],[0 cosecante], ...
    'Color',[0.4138 0.1724 0],'LineStyle','-','LineWidth',6);
leglab{J} = 'Cosecant'; J = J+1;

% Sine
plot([coseno coseno],[0 seno], ...
    'Color',[1 0.3686 0.0549],'LineStyle','--','LineWidth',1);
L(J) = plot([0 0],[0 seno], ...
    'Color',[1 0.3686 0.0549],'LineWidth',2);
leglab{J} = 'Sine (sin)'; J = J+1;

% Versed cosine
L(J) = plot([0 0],[seno seno+coversin], ...
    'Color',[0.8621 1 0.7241],'LineWidth',2);
leglab{J} = 'Versed Cosine (coversin)'; J = J+1;

% External cosecant
L(J) = plot([0 0],[yAnchor yAnchor+excsc], ...
    'Color',[1 0.5686 0.6863],'LineWidth',2);
leglab{J} = 'External Cosecant (excsc)'; J = J+1;

% Tangent
L(J) = plot([coseno secante],[seno 0], ...
    'Color',[0.5172 0.5172 1],'LineWidth',2);
leglab{J} = 'Tangent (tan)'; J = J+1;

% Cotangent
L(J) = plot([0 coseno],[cosecante seno], ...
    'Color',[0.5862 0.8276 0.3103],'LineWidth',2);
leglab{J} = 'Cotangent (cot)'; 

% Fix the view window so the unit circle is always visible
set(gca,'XLim',[-2.5 2.5],'YLim',[-2.5 2.5]);

legend(L,leglab,'Location','NorthEastOutside');
title('Goniometric Circle','FontSize',16,'FontWeight','Bold')
xlabel('x')
ylabel('y')
hold off

end

% -------------------------------------------------------------------------
% Local helpers: exact values and formatting
% -------------------------------------------------------------------------
function s = trigExact(func, degAngle)
%TRIGEXACT Return exact trig value for special angles in degrees.
%
%   s = trigExact(func, degAngle)
%   func     : 'cos', 'sin', 'tan', 'sec', 'csc', or 'cot'
%   degAngle : angle in degrees (not necessarily integer)
%
%   Returns:
%     - '' (empty) if no exact form is available;
%     - a char array with an exact symbolic-like expression otherwise,
%       e.g. '√3/2', '√2/2', '1/√3', 'Inf'.

persistent T

if isempty(T)
    keys = {'0','30','45','60','90','120','135','150', ...
            '180','210','225','240','270','300','315','330'};
    % cos
    T.cos = containers.Map( ...
        keys, ...
        {'1', '√3/2', '√2/2', '1/2', '0', ...
        '-1/2', '-√2/2', '-√3/2', '-1', ...
        '-√3/2', '-√2/2', '-1/2', '0', ...
        '1/2', '√2/2', '√3/2'} );
    % sin
    T.sin = containers.Map( ...
        keys, ...
        {'0', '1/2', '√2/2', '√3/2', '1', ...
        '√3/2', '√2/2', '1/2', '0', ...
        '-1/2', '-√2/2', '-√3/2', '-1', ...
        '-√3/2', '-√2/2', '-1/2'} );
    % tan
    T.tan = containers.Map( ...
        keys, ...
        {'0', '1/√3', '1', '√3', 'Inf', ...
        '-√3', '-1', '-1/√3', '0', ...
        '1/√3', '1', '√3', 'Inf', ...
        '-√3', '-1', '-1/√3'} );
    % sec
    T.sec = containers.Map( ...
        keys, ...
        {'1', '2/√3', '√2', '2', 'Inf', ...
        '-2', '-√2', '-2/√3', '-1', ...
        '-2/√3', '-√2', '-2', 'Inf', ...
        '2', '√2', '2/√3'} );
    % csc
    T.csc = containers.Map( ...
        keys, ...
        {'Inf', '2', '√2', '2/√3', '1', ...
        '2/√3', '√2', '2', 'Inf', ...
        '-2', '-√2', '-2/√3', '-1', ...
        '-2/√3', '-√2', '-2'} );
    % cot
    T.cot = containers.Map( ...
        keys, ...
        {'Inf', '√3', '1', '1/√3', '0', ...
        '-1/√3', '-1', '-√3', 'Inf', ...
        '√3', '1', '1/√3', '0', ...
        '-1/√3', '-1', '-√3'} );
end

% Normalize to [0,360) and snap to nearest integer degree
degNorm  = mod(degAngle, 360);
degRound = round(degNorm);

if abs(degNorm - degRound) > 1e-10
    s = ''; % not an exact special angle
    return
end

key = num2str(mod(degRound, 360));

if ~isfield(T, func) || ~isKey(T.(func), key)
    s = '';
else
    s = T.(func)(key);
end

end

function s = chordExact(degAngle)
%CHORDEXACT Exact chord length for special angles, if available.
%
%   s = chordExact(degAngle)
%   Uses the identity Chord(θ) = 2*sin(θ/2) and the exact forms of
%   sin(θ/2) to derive an exact radical expression when possible.

sinHalf = trigExact('sin', degAngle/2);
if isempty(sinHalf)
    s = '';
    return
end

switch sinHalf
    case '0'
        s = '0';
    case '1/2'
        s = '1';
    case '-1/2'
        s = '-1';
    case '√2/2'
        s = '√2';
    case '-√2/2'
        s = '-√2';
    case '√3/2'
        s = '√3';
    case '-√3/2'
        s = '-√3';
    case '1'
        s = '2';
    case '-1'
        s = '-2';
    otherwise
        s = '';
end

end

function valOut = formatExactNumeric(exactStr, numericVal)
%FORMATEXACTNUMERIC Combine exact form (if any) with numeric approximation.
%
%   Behaviour:
%   - If exactStr is empty, returns numericVal.
%   - If exactStr is 'Inf' or '-Inf', returns it as-is (no approximation).
%   - If exactStr is '0', '1', or '-1', returns it as-is (no approximation).
%   - If exactStr is non-empty and numericVal is finite, returns a char
%     like '√3/2 (≈ 0.8660)'.
%   - If numericVal is Inf or -Inf but the exact form is finite, returns
%     the exact form alone.

if isempty(exactStr)
    valOut = numericVal;
    return
end

% Infinite exact forms: do not append numeric approximation
if strcmp(exactStr,'Inf') || strcmp(exactStr,'-Inf')
    valOut = exactStr;
    return
end

% Pure integer exact forms 0, 1, -1: no numeric suffix
if any(strcmp(exactStr, {'0','1','-1'}))
    valOut = exactStr;
    return
end

if isinf(numericVal)
    % Numeric overflow, but exact form is finite: use the exact form only
    valOut = exactStr;
else
    valOut = sprintf('%s (≈ %.4f)', exactStr, numericVal);
end

end
