import java.util.HashSet;

public class Graph {
    int[][] adjMatrix;
    Edge[] edges;
    Node[] nodes;

    public Graph(int[][] adjMatrix) {
        this.adjMatrix = adjMatrix;
        this.createGraph();
    }

    public void createGraph() {
        int length = (this.adjMatrix.length) * (this.adjMatrix.length - 1) / 2;
        edges = new Edge[length];
        length = this.adjMatrix.length;
        nodes = new Node[length];
        for (int i = 0; i < nodes.length; i++) {
            nodes[i] = new Node(100 + i);
        }
        int counter = 0;
        for (int i = 0; i < this.adjMatrix.length; i++) {
            for (int j = 0; j < i; j++) {
                edges[counter] = new Edge(nodes[i], nodes[j], adjMatrix[i][j]);
                nodes[i].addEdge(edges[counter]);
                nodes[j].addEdge(edges[counter]);
                counter++;
            }
        }
    }

    public Edge getMinEdge(HashSet<Edge> edges) {
        Edge edge = null, tempEdge = null;
        int minWeight = Integer.MAX_VALUE;
        Object[] temp = edges.toArray();
        for (int i = 0; i < temp.length; i++) {
            tempEdge = (Edge) temp[i];
            if ((tempEdge.getWeight() < minWeight)
                    && !tempEdge.areNodesVisited() && !tempEdge.isUsed()) {
                minWeight = tempEdge.getWeight();
                edge = tempEdge;
            }
        }
        return edge;
    }


    public Edge[] performPrim(int startPoint) {

        HashSet<Edge> mstEdge = new HashSet<Edge>();
        nodes[startPoint].setVisited(true);
        do {
            HashSet<Node> visitedNodes = this.getVisitedNodes();
            Object[] vnodes = visitedNodes.toArray();
            HashSet<Edge> edgeList=new HashSet<Edge>();
            for(int i=0;i<vnodes.length;i++) {
                Object []egs=((Node)vnodes[i]).getEdges().toArray();
                for(int j=0;j<egs.length;j++) {
                    if(!((Edge)egs[j]).isUsed()) {
                        edgeList.add((Edge)egs[j]);
                    }
                }
            }
            try {
                Edge temp=getMinEdge(edgeList);
                temp.setUsed();
                mstEdge.add(temp);
            } catch (Exception e) {
            }
        } while (isGraphVisited());
        Object[] finalEdges= mstEdge.toArray();
        Edge[] result = new Edge[finalEdges.length];
        for (int i = 0; i < finalEdges.length; ++i) {
          result[i] = (Edge) finalEdges[i];
        }
        return (result);
    }

    public HashSet<Node> getVisitedNodes() {
        HashSet<Node> visitedNodes = new HashSet<Node>();
        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i].isVisited()) {
                visitedNodes.add(nodes[i]);
            }
        }
        return visitedNodes;
    }

    public boolean isGraphVisited() {
        for (int i = 0; i < nodes.length; i++) {
            if (!nodes[i].isVisited()) {
                return true;
            }
        }
        return false;
    }

}
