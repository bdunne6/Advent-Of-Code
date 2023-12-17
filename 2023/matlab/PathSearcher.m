classdef PathSearcher < handle
    %PATHSEARCHER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        m
        t
        wbest
        pbest
        i_cnt
    end
    
    methods
        function obj = PathSearcher(m)
            %PATHSEARCHER Construct an instance of this class
            obj.m = m;
            obj.t = zeros(size(m));
            obj.wbest = inf(size(m));
            obj.pbest = cell(size(m));
            obj.i_cnt = 0;
        end
        
        function dfs(obj,p)
            %             w_new = p.w + obj.m(p.rc(1),p.rc(2))
            obj.i_cnt = obj.i_cnt + 1;
            
            if (p.w>=obj.wbest(p.rc(1),p.rc(2)))||(p.w>=obj.wbest(end))
                return;
            else
                obj.wbest(p.rc(1),p.rc(2)) = p.w;
            end
            if all(p.rc == size(obj.m))
                return;
            end
            
            
            m = obj.m;
            d = fliplr(p.dir);
            d = [d;-d];
            if p.n_steps < 3
                d = [d;p.dir];
            else
                p.n_steps = 0;
            end
            rc1 = p.rc + d;
            i_v = false(size(rc1,1),1);
            for i1 = 1:size(rc1,1)
                i_v(i1) = (rc1(i1,1)<=size(m,1))&&(rc1(i1,2)<=size(m,2))&&(rc1(i1,1)>0)&&(rc1(i1,2)>0);
            end
            
            rc1 = rc1(i_v,:);
            d1 = d(i_v,:);
            if mod(obj.i_cnt,50000) == 0
                figure(101)
                imagesc(obj.wbest);
                colorbar;
                %caxis([0 50000])
                drawnow();
                
            end
            
            
            %             obj.t(p.rc(1),p.rc(2)) = obj.t(p.rc(1),p.rc(2))+1;
            %             figure(101)
            %             imagesc(obj.wbest);
            %             drawnow();
            %             mt = zeros(size(m));
            %             mt(p.rc(1),p.rc(2)) = 1;
            %             imagesc(mt);
            %             drawnow();
            
            for i1 = 1:size(rc1,1)
                pn_i1 = p;
                pn_i1.rc = rc1(i1,:);
                pn_i1.w = pn_i1.w + m(rc1(i1,1),rc1(i1,2));
                if all(d1(i1,:)==pn_i1.dir)
                    pn_i1.n_steps = pn_i1.n_steps + 1;
                end
                pn_i1.dir = d1(i1,:);
                obj.dfs(pn_i1);
            end
            
        end
        
        function bfs(obj,p)
            %             w_new = p.w + obj.m(p.rc(1),p.rc(2))
            %obj.i_cnt = obj.i_cnt + 1;
            q = [];
            q = cat(1,q,p);
            
            while ~isempty(q)
                p = q(end);
                q(end) = [];
                %                 if all(p.rc == size(obj.m))
                %                     return;
                %                 end
                
                if p.w>=obj.wbest(p.rc(1),p.rc(2))
                    continue;
                else
                    obj.wbest(p.rc(1),p.rc(2)) = p.w;
                end
                
                m = obj.m;
                d = fliplr(p.dir);
                d = [d;-d];
                if p.n_steps < 3
                    d = [d;p.dir];
                else
                    p.n_steps = 0;
                end
                rc1 = p.rc + d;
                i_v = false(size(rc1,1),1);
                for i1 = 1:size(rc1,1)
                    i_v(i1) = (rc1(i1,1)<=size(m,1))&&(rc1(i1,2)<=size(m,2))&&(rc1(i1,1)>0)&&(rc1(i1,2)>0);
                end
                
                rc1 = rc1(i_v,:);
                d1 = d(i_v,:);
                %             if mod(obj.i_cnt,1) == 0
                %                 figure(101)
                %                 imagesc(obj.wbest);
                %                 	colorbar;
                %                     %caxis([0 50000])
                %                 drawnow();
                %
                %             end
                
                
                %             obj.t(p.rc(1),p.rc(2)) = obj.t(p.rc(1),p.rc(2))+1;
                %                 figure(101)
                %                 imagesc(obj.wbest);
                %                 drawnow();
                %             mt = zeros(size(m));
                %             mt(p.rc(1),p.rc(2)) = 1;
                %             imagesc(mt);
                %             drawnow();
                nq = numel(q);
                for i1 = 1:size(rc1,1)
                    pn_i1 = p;
                    pn_i1.rc = rc1(i1,:);
                    pn_i1.w = pn_i1.w + m(rc1(i1,1),rc1(i1,2));
                    if all(d1(i1,:)==pn_i1.dir)
                        pn_i1.n_steps = pn_i1.n_steps + 1;
                    end
                    pn_i1.dir = d1(i1,:);
                    %obj.dfs(pn_i1);
                    if isempty(q)
                        q = pn_i1;
                    else
                        q = cat(1,pn_i1,q);
                    end
                end
                
            end
        end
    end
end

