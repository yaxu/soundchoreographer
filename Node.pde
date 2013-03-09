import java.util.HashSet;

public class Node {
    private int nodeId;
    private boolean visited;
    private HashSet<Edge> edges;

    public Node(int nodeId) {
        this.nodeId = nodeId;
        this.visited = false;
        edges = new HashSet<Edge>();
    }

    public int getNodeId() {
        return nodeId;
    }

    public boolean isVisited() {
        return visited;
    }

    public void setVisited(boolean visited) {
        this.visited = visited;
    }

    public HashSet<Edge> getEdges() {
        return edges;
    }

    public void addEdge(Edge edge) {
        edges.add(edge);
    }
}


