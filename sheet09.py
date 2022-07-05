class Synthesis():
    def __init__(self,fd=None,filename=None):
        self.fd=fd
        self.filename=filename
    def prepare(self):
        input_f=[]
        if self.filename:
            with open(self.filename,'r') as fp:
                for item in fp.readlines():
                    line=item.replace("\n","")
                    line_list=line.split("-> ")
                    links=line_list[0].split(" ")
                    rechts=line_list[1].split(" ")
                    input_f.append([links, rechts])
        self.fd=np.array(input_f)
        print(self.fd)
                    
                        
    def compute_canonical(self):
        pass
    def create_schemas(self):
        pass
    def run(self):
        pass
    def attrHuelle(self,alpha, f=None):
        alpha_plus=alpha
        f=self.fd.copy() if f is None else f
        
        change=True
        while change:
            old_alpha=alpha_plus.copy()
            for  gamma in f:
                if np.all(np.isin(gamma[0],alpha_plus)):
                    tmp=np.hstack(np.append(alpha_plus,gamma[1]))
                    alpha_plus=np.array(list(set(tmp)))
            #cond=np.array([np.min(np.isin(self.fd[i,0],alpha_plus)) for i in range(self.fd.shape[0])])
            
            #print(alpha,": ", alpha_plus)
            if alpha_plus.shape==old_alpha.shape and np.all(alpha_plus[np.argsort(alpha_plus)]==old_alpha[np.argsort(old_alpha)]):
                change=False
            old_alpha=alpha_plus.copy()
        return alpha_plus
    
    def linksreduktion(self):
        fd_links=self.fd.copy()
        for attrmenge in fd_links:
            
            if len(attrmenge[0])>1:
                links=attrmenge[0]
                for i in range(len(links)):                    
                    
                    rest=links[:i]+links[i+1:]
                    #print("element ", links[i])
                    attr_huelle=self.attrHuelle(np.array(rest))
                    if len(rest)!=len(attr_huelle) and links[i] in attr_huelle:
                        #remove element
                        attrmenge[0]=rest
        return fd_links
    def rechtsreduktion(self):
        fd_rechts=self.linksreduktion()
        attr_counter=0
        for attrmenge in fd_rechts:
            fd_rechts_tmp=fd_rechts.copy()
            if len(attrmenge[1])>1:
                rechts=attrmenge[1]
                links=attrmenge[0]
                fd_rechts_tmp=np.delete(fd_rechts_tmp, attr_counter,0)
                #print("deleted?",fd_rechts_tmp)
                for i in range(len(rechts)):
                    rest=rechts[:i]+rechts[i+1:]
                    new_fd=fd_rechts_tmp.copy()
                    #np.vstack((new_fd,list([links, rechts]))) 
                    new_fd_list=new_fd.tolist()
                    new_fd_list.append([links, rest])
                    new_fd=np.array(new_fd_list)
                    
                    
                    #print("element ", links[i])
                    #print("removed?:", fd_rechts[attr_counter])
                    #print("new fd:", new_fd)
                    attr_huelle=self.attrHuelle(np.array(links), f=new_fd)
                    #print(links,attr_huelle)
                    if len(links)!=len(attr_huelle) and rechts[i] in attr_huelle:
                        #remove element
                        #print(links, rest, rechts[i], rechts, attr_huelle)
                        attrmenge[1]=rest   
            attr_counter=attr_counter+1
            #break
        return fd_rechts
    
    def remove_leere_kaluseln(self,fd=None):
        fd_copy=fd.copy()
        for i in range(fd_copy.shape[0]):
            if fd_copy[i][1].size==0:
                fd=np.delete(fd,i,0)
        return fd
    
    def  zusammenfassen(self,fd):
        fd_copy=fd.copy()
        alle_linke=fd_copy[:,0]
        to_delete=[]
        for i in range(fd_copy.shape[0]):
            indexes=[]
            for item in range(fd_copy.shape[0]):
                if(alle_linke[i]==fd_copy[item][0]) and i<item :
                    #print("equal? ",(fd_copy[i][0],fd_copy[item][0]))

                    indexes.extend([i,item])
            #union
            if len(indexes)<1:
                continue
            new_right=[]
            print(indexes)
            to_delete.extend(indexes)
            new_fd=None
            #print(fd)
            for index in indexes:
                new_right.extend(fd_copy[index][1])

                
            #print("new_right: ", new_right)
            new_left=fd_copy[i][0]
            #new_fd=np.delete(fd,i,0)
            new_fd=fd.tolist()
            new_fd.append([new_left, new_right])
            fd=np.array(new_fd)
        #delete the old values
        fd=np.delete(fd,to_delete,0)
            
            
        return fd
    def run(self):
            links=self.linksreduktion()
            rechts=self.rechtsreduktion(links)
            leer=self.remove_leere_kaluseln(rechts)
            zusammen=self.zusammenfassen(leer)
            for i in zusammen:
                res=[]
                for j in i:
                    res.extend(j)
                print(" ".join(res))
                    
                
if __name__=="__main__":
    params=sys.argv
    
    filename=params[-1]
    syn=Synthesis(filename=filename)
    syn.prepare()
    syn.run()
    
