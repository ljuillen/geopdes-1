% -*- INTERNAL UNDOCUMENTED FUNCTION -*-
%
% Copyright (C) 2010 Carlo de Falco
% Copyright (C) 2013 Marco Pingaro
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Octave; see the file COPYING.  If not, see
% <http://www.gnu.org/licenses/>.
% Author: Carlo de Falco <cdf AT users.sourceforge.net>

%%
function [bxxx, bxxy, bxyy, byyy] = der3_basisfun_phys__ (xu, xv, yu,...
    yv, xuu, xuv, xvv, yuu, yuv, yvv, xuuu, xuuv, xuvv, xvvv, yuuu, yuuv, yuvv, yvvv,...
    buuu, buuv, buvv, bvvv, buu, buv, bvv, bu, bv)

det = (-xv .* yu + xu .* yv);

ux =  yv ./ det;
uy = -xv ./ det;
vx = -yu ./ det;
vy =  xu ./ det;

bx = bu.*ux + bv.*vx;
by = bu.*uy + bv.*vy;
 
bxx = (buu - bx.*xuu - by.*yuu).*ux.*ux + 2.*(buv - bx.*xuv - by.*yuv).*vx.*ux +...
      (bvv - bx.*xvv - by.*yvv).*vx.*vx;
byy = (buu - bx.*xuu - by.*yuu).*uy.*uy + 2.*(buv - bx.*xuv - by.*yuv).*vy.*uy + ...
      (bvv - bx.*xvv - by.*yvv).*vy.*vy;
bxy = (buu - bx.*xuu - by.*yuu).*ux.*uy + (buv - bx.*xuv - by.*yuv).*(vx.*uy + ux.*vy) + ...
      (bvv - bx.*xvv - by.*yvv).*vx.*vy;

%% My Version
bxxx = (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xuu.*xu - 3.*byy.*yuu.*yu - bxy.*(3.*yuu.*xu + 3.*xuu.*yu)).*ux.*ux.*ux+...
       (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xvv.*xv - 3.*byy.*yvv.*yv - bxy.*(3.*yvv.*xv + 3.*yv.*xvv)).*vx.*vx.*vx+...
       (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - byy.*(2.*yuv.*yu + yuu.*yv)...
       - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv)).*(vx.*ux.*ux + ux.*vx.*ux + ux.*ux.*vx)+...
       (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)...
       - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu)).*(vx.*vx.*ux + vx.*ux.*vx + ux.*vx.*vx);
  
byyy = (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xuu.*xu - 3.*byy.*yuu.*yu - bxy.*(3.*yuu.*xu + 3.*xuu.*yu)).*uy.*uy.*uy+...
       (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xvv.*xv - 3.*byy.*yvv.*yv - bxy.*(3.*yvv.*xv + 3.*yv.*xvv)).*vy.*vy.*vy+...
       (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - byy.*(2.*yuv.*yu + yuu.*yv)...
       - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv)).*(vy.*uy.*uy + uy.*vy.*uy + uy.*uy.*vy)+...
       (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)...
       - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu)).*(vy.*vy.*uy + vy.*uy.*vy + uy.*vy.*vy);
    
bxxy = (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xuu.*xu - 3.*byy.*yuu.*yu - bxy.*(3.*yuu.*xu + 3.*xuu.*yu)).*ux.*ux.*uy+...
      (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xvv.*xv - 3.*byy.*yvv.*yv - bxy.*(3.*yvv.*xv + 3.*yv.*xvv)).*vx.*vx.*vy+...
      (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - byy.*(2.*yuv.*yu + yuu.*yv)...
      - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv)).*(vx.*ux.*uy + ux.*vx.*uy + ux.*ux.*vy)+...
      (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)...
      - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu)).*(vx.*vx.*uy + vx.*ux.*vy + ux.*vx.*vy);
  
bxyy = (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xuu.*xu - 3.*byy.*yuu.*yu - bxy.*(3.*yuu.*xu + 3.*xuu.*yu)).*ux.*uy.*uy+...
       (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xvv.*xv - 3.*byy.*yvv.*yv - bxy.*(3.*yvv.*xv + 3.*yv.*xvv)).*vx.*vy.*vy+...
       (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - byy.*(2.*yuv.*yu + yuu.*yv)...
       - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv)).*(vx.*uy.*uy + ux.*vy.*uy + ux.*uy.*vy)+...
       (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)...
       - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu)).*(vx.*vy.*uy + vx.*uy.*vy + ux.*vy.*vy);
end

%  bxxy = buuu.*ux.*ux.*uy + bvvv.*vx.*vx.*vy+...
%      buuv.*(ux.*ux.*vy+ux.*vx.*uy+vx.*ux.*uy)+...
%      buvv.*(ux.*vx.*vy+vx.*ux.*vy+vx.*vx.*uy)-...
%      bx.*xuuu.*ux.*ux.*uy-bx.*xvvv.*vx.*vx.*vy-...
%      bx.*xuuv.*(ux.*ux.*vy+ux.*vx.*uy+vx.*ux.*uy)-...
%      bx.*xuvv.*(ux.*vx.*vy+vx.*ux.*vy+vx.*vx.*uy)-...
%      by.*yuuu.*ux.*ux.*uy-by.*yvvv.*vx.*vx.*vy-...
%      by.*yuuv.*(ux.*ux.*vy+ux.*vx.*uy+vx.*ux.*uy)-...
%      by.*yuvv.*(ux.*vx.*vy+vx.*ux.*vy+vx.*vx.*uy)-...
%      bxx.*(xuu.*xu+xu.*xuu+xu.*xuu).*ux.*ux.*uy-...
%      bxx.*(xuv.*xu+xu.*xuv+xv.*xuu).*ux.*ux.*vy-...
%      bxx.*(xuv.*xu+xv.*xuu+xu.*xuv).*ux.*vx.*uy-...
%      bxx.*(xvv.*xu+xv.*xuv+xv.*xuv).*ux.*vx.*vy-...
%      bxx.*(xuu.*xv+xu.*xuv+xu.*xuv).*vx.*ux.*uy-...
%      bxx.*(xuv.*xv+xu.*xvv+xv.*xuv).*vx.*ux.*vy-...
%      bxx.*(xuv.*xv+xv.*xuv+xu.*xvv).*vx.*vx.*uy-...
%      bxx.*(xvv.*xv+xv.*xvv+xv.*xvv).*vx.*vx.*vy-...
%      byy.*(yuu.*yu+yu.*yuu+yu.*yuu).*ux.*ux.*uy-...
%      byy.*(yuv.*yu+yu.*yuv+yv.*yuu).*ux.*ux.*vy-...
%      byy.*(yuv.*yu+yv.*yuu+yu.*yuv).*ux.*vx.*uy-...
%      byy.*(yvv.*yu+yv.*yuv+yv.*yuv).*ux.*vx.*vy-...
%      byy.*(yuu.*yv+yu.*yuv+yu.*yuv).*vx.*ux.*uy-...
%      byy.*(yuv.*yv+yu.*yvv+yv.*yuv).*vx.*ux.*vy-...
%      byy.*(yuv.*yv+yv.*xuv+yu.*yvv).*vx.*vx.*uy-...
%      byy.*(yvv.*yv+yv.*xvv+yv.*yvv).*vx.*vx.*vy-...
%      bxy.*(yuu.*xu+yu.*xuu+yu.*xuu+xuu.*yu+xu.*yuu+xu.*yuu).*ux.*ux.*uy-...
%      bxy.*(yuv.*xu+yu.*xuv+yv.*xuu+xuv.*yu+xu.*yuv+xv.*yuu).*ux.*ux.*vy-...
%      bxy.*(yuv.*xu+yv.*xuu+yu.*xuv+xuv.*yu+xv.*yuu+xu.*yuv).*ux.*vx.*uy-...
%      bxy.*(yvv.*xu+yv.*xuv+yv.*xuv+xvv.*yu+xv.*yuv+xv.*yuv).*ux.*vx.*vy-...
%      bxy.*(yuu.*xv+yu.*xuv+yu.*xuv+xuu.*yv+xu.*yuv+xu.*yuv).*vx.*ux.*uy-...
%      bxy.*(yuv.*xv+yv.*xvv+yv.*xuv+xuv.*yv+xu.*yvv+xv.*yuv).*vx.*ux.*vy-...
%      bxy.*(yuv.*xv+yv.*xuv+yu.*xvv+xuv.*yv+xv.*yuv+xu.*yvv).*vx.*vx.*uy-...
%      bxy.*(yvv.*xv+yv.*xvv+yv.*xvv+xvv.*yv+xv.*yvv+xv.*yvv).*vx.*vx.*vy;


%% Mia Versione Estesa
% bxxx = ...
% (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xu.*xuu - 3.*byy.*yu.*yuu - bxy.*(2.*yuu.*xu + 2.*xuu.*yu + yu.*xuu + xu.*yuu)).*ux.*ux.*ux+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yv.*xuu + xv.*yuu) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*ux.*vx+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*vx.*ux+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*xuv.*yv + 2.*yuv.*xv + yvv.*xu + xvv.*yu) - byy.*(2.*yuv.*yv + yvv.*yu)).*ux.*vx.*vx+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yuu.*xv + xuu.*yv) - byy.*(2.*yuv.*yu + yuu.*yv)).*vx.*ux.*ux+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*ux.*vx+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*vx.*ux+...
% (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xv.*xvv - 3.*byy.*yv.*yvv - bxy.*(2.*yvv.*xv + 2.*xvv.*yv + yv.*xvv + xv.*yvv)).*vx.*vx.*vx;  
%   
% byyy = ...
% (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xu.*xuu - 3.*byy.*yu.*yuu - bxy.*(2.*yuu.*xu + 2.*xuu.*yu + yu.*xuu + xu.*yuu)).*uy.*uy.*uy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xv.*xuu) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yv.*xuu + xv.*yuu) - byy.*(2.*yuv.*yu + yv.*yuu)).*uy.*uy.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv) - byy.*(2.*yuv.*yu + yv.*yuu)).*uy.*vy.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*xuv.*yv + 2.*yuv.*xv + yvv.*xu + xvv.*yu) - byy.*(2.*yuv.*yv + yvv.*yu)).*uy.*vy.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yuu.*xv + xuu.*yv) - byy.*(2.*yuv.*yu + yuu.*yv)).*vy.*uy.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vy.*uy.*vy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vy.*vy.*uy+...
% (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xv.*xvv - 3.*byy.*yv.*yvv - bxy.*(2.*yvv.*xv + 2.*xvv.*yv + yv.*xvv + xv.*yvv)).*vy.*vy.*vy;  
%   
% bxxy = ...
% (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xu.*xuu - 3.*byy.*yu.*yuu - bxy.*(2.*yuu.*xu + 2.*xuu.*yu + yu.*xuu + xu.*yuu)).*ux.*ux.*uy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xv.*xuu) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yv.*xuu + xv.*yuu) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*ux.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*vx.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*xuv.*yv + 2.*yuv.*xv + yvv.*xu + xvv.*yu) - byy.*(2.*yuv.*yv + yvv.*yu)).*ux.*vx.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yuu.*xv + xuu.*yv) - byy.*(2.*yuv.*yu + yuu.*yv)).*vx.*ux.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*ux.*vy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*vx.*uy+...
% (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xv.*xvv - 3.*byy.*yv.*yvv - bxy.*(2.*yvv.*xv + 2.*xvv.*yv + yv.*xvv + xv.*yvv)).*vx.*vx.*vy;
% 
% bxyy = ...
% (buuu - bx.*xuuu - by.*yuuu - 3.*bxx.*xu.*xuu - 3.*byy.*yu.*yuu - bxy.*(2.*yuu.*xu + 2.*xuu.*yu + yu.*xuu + xu.*yuu)).*ux.*uy.*uy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xv.*xuu) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yv.*xuu + xv.*yuu) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*uy.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*yuv.*xu + 2.*xuv.*yu + xuu.*yv + yuu.*xv) - byy.*(2.*yuv.*yu + yv.*yuu)).*ux.*vy.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*xuv.*yv + 2.*yuv.*xv + yvv.*xu + xvv.*yu) - byy.*(2.*yuv.*yv + yvv.*yu)).*ux.*vy.*vy+...
% (buuv - bx.*xuuv - by.*yuuv - bxx.*(2.*xuv.*xu + xuu.*xv) - bxy.*(2.*xuv.*yu + 2.*yuv.*xu + yuu.*xv + xuu.*yv) - byy.*(2.*yuv.*yu + yuu.*yv)).*vx.*uy.*uy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*uy.*vy+...
% (buvv - bx.*xuvv - by.*yuvv - bxx.*(2.*xuv.*xv + xvv.*xu) - bxy.*(2.*yuv.*xv + 2.*xuv.*yv + xvv.*yu + yvv.*xu) - byy.*(2.*yuv.*yv + yvv.*yu)).*vx.*vy.*uy+...
% (bvvv - bx.*xvvv - by.*yvvv - 3.*bxx.*xv.*xvv - 3.*byy.*yv.*yvv - bxy.*(2.*yvv.*xv + 2.*xvv.*yv + yv.*xvv + xv.*yvv)).*vx.*vy.*vy;
