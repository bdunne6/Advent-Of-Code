classdef PathSearcher < handle
    %PATHSEARCHER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        m
        t
        wbest
    end
    
    methods
        function obj = PathSearcher(m)
            %PATHSEARCHER Construct an instance of this class
            obj.m = m;
            obj.t = zeros(size(m));
            obj.wbest = inf(size(m));
        end
        
        function search_paths(obj,p)
            
            %             w_new = p.w + obj.m(p.rc(1),p.rc(2))
            if p.w>=obj.wbest(p.rc(1),p.rc(2))
                return;
            else
                obj.wbest(p.rc(1),p.rc(2)) = p.w;
            end
            
            m = obj.m;
            d = fliplr(p.dir);
            d = [d;-d];
            if p.n_steps < 3
                d = [d;p.dir];
            end
            rc1 = p.rc + d;
            i_v = false(size(rc1,1),1);
            for i1 = 1:size(rc1,1)
                i_v(i1) = (rc1(i1,1)<=size(m,1))&&(rc1(i1,2)<=size(m,2))&&(rc1(i1,1)>0)&&(rc1(i1,2)>0);
            end
            
            rc1 = rc1(i_v,:);
            d1 = d(i_v,:);
            
            
            
            obj.t(p.rc(1),p.rc(2)) = obj.t(p.rc(1),p.rc(2))+1;
                        figure(101)
                        imagesc(obj.wbest);
                        drawnow();
            
            for i1 = 1:size(rc1,1)
                pn(i1) = p;
                pn(i1).rc = rc1(i1,:);
                pn(i1).w = pn(i1).w + m(rc1(i1,1),rc1(i1,2));
                if all(d1(i1,:)==pn(i1).dir)
                    pn(i1).n_steps = pn(i1).n_steps + 1;
                end
                obj.search_paths(pn(i1));
            end
            
        end
    end
end

