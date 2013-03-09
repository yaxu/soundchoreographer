class Tree {
 
 ArrayList nodes;
 ArrayList cxs = new ArrayList();
 
 Tree(ArrayList nodes) {
   this.nodes = nodes;
 }

/* 
 void updateCosts() {
   for (int i = 0; i < num_nodes; ++i) {
     Connection cx = (Connection) cxs.get(i);
     cx.updateCost();
   }
 }
 */
  void connect() {
    int num_nodes = nodes.size();

    int[][] matrix = new int[num_nodes][num_nodes];
    for (int i = 0; i < num_nodes; ++i) {
      Instruction from = (Instruction) nodes.get(i);
      from.cxs.clear();
      for (int j = 0; j < num_nodes; ++j) {
        Instruction to = (Instruction) nodes.get(j);
        matrix[i][j] = (int) Math.floor(10000*sqrt(sq(abs(from.x - to.x)) + sq(from.y - to.y)));
      }
    }
    Graph graph = new Graph(matrix);
    Edge[] edges = graph.performPrim(0);
    //print("found: " + edges.length + " edges.\n");
    for (int i = 0; i < edges.length; ++i) {
      Instruction from = (Instruction) nodes.get(edges[i].node1.nodeId - 100);
      Instruction to = (Instruction) nodes.get(edges[i].node2.nodeId - 100);
      from.cxs.add(to);
    }
  }  
}
