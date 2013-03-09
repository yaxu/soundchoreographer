 import java.util.HashSet;

public class Edge {
    Node node1, node2;
    private int weight;
    private boolean isUsed = false;

    Edge(Node node1, Node node2, int weight) {
        this.node1 = node1;
        this.node2 = node2;
        this.weight = weight;
    }

    public int getWeight() {
        return weight;
    }

    public void setNodesVisited() {
        node1.setVisited(true);
        node2.setVisited(true);
    }

    public boolean areNodesVisited() {
        return (node1.isVisited() & node2.isVisited());
    }

    public void setUsed() {
        isUsed = true;
        setNodesVisited();
    }

    public boolean isUsed() {
        return isUsed;
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

}


