import java.io.*;
import java.util.*;

class Node {
    private int id;
    private int costHW;
    private int costSW;

    private int[] hwUsage = {2,32,26,73,98,15,82,14,39,82};
    private int[] swUsage = {98,68,74,27,2,85,18,86,61,18};

    public Node(int id) {
        this.id = id;
        this.costHW = hwUsage[id];
        this.costSW = swUsage[id];
    }

    public Node(int id,int costHW,int costSW) {
        this.id = id;
        this.costHW = costHW;
        this.costSW = costSW;
    }

    public int getId() {
        return id;
    }

    public int getCostHW() {
        return costHW;
    }

    public int getCostSW() {
        return costSW;
    }

    public void swap() {
        int temp = costHW;
        costHW = costSW;
        costSW = temp;
    }

    public int[] getDiff(Node n) {
        int hwDiff = Math.abs(costHW + n.getCostHW());
        int swDiff = Math.abs(costSW + n.getCostSW());
        int[] arr = new int[2];
        arr[0] = hwDiff;
        arr[1] = swDiff;
        return arr;
    }

    @Override
    public String toString() {
        return "Cost: HW -\t"+getCostHW()+"\tSW -\t"+getCostSW()+"\tid -\t"+getId();
    }
}

class NodeList {
    private static ArrayList<Node> nodes = new ArrayList<>();

    public static void addNode(Node n) {
        nodes.add(n);
    }

    public static Node getNode(int index) {
        return (Node)nodes.get(index);
    }

    public static int numberOfNodes() {
        return nodes.size();
    }
}

class NodeTraversed {
    private ArrayList<Node> nodesTraversed = new ArrayList<>();

    private int[] sumOfNodes = new int[2];

    public NodeTraversed() {
        for(int i=0;i<NodeList.numberOfNodes();i++) {
            nodesTraversed.add(null);
        }
    }

    public NodeTraversed(ArrayList<Node> traversed) {
        this.nodesTraversed = new ArrayList<>(traversed);
    }

    public ArrayList<Node> getNodesTraversed() {
        return nodesTraversed;
    }

    public void generateNodes() {
        for(int i=0;i<NodeList.numberOfNodes();i++) {
            setNode(i,NodeList.getNode(i));
        }
        Collections.shuffle(nodesTraversed);
    }

    public Node getNode(int pos) {
        return (Node)nodesTraversed.get(pos);
    }

    public void setNode(int pos, Node node) {
        nodesTraversed.set(pos,node);
        sumOfNodes = new int[2];
    }
    
    public int nodesTraversedSize() {
        return nodesTraversed.size();
    }

    public int[] diff() {
        int sumHW=0;
        int sumSW=0;
        for(int i=0;i<nodesTraversedSize();i++) {
            Node n1 = getNode(i);
            Node n2;
            if(i+1<nodesTraversedSize()) {
                n2 = getNode(i+1);
            }
            else {
                n2 = getNode(0);
            }

            sumHW += n1.getDiff(n2)[0];
            sumSW += n2.getDiff(n2)[1];
        }
        sumOfNodes[0] = sumHW;
        sumOfNodes[1] = sumSW;
        return sumOfNodes;
    }
    
    @Override
    public String toString() {
        StringBuilder outputString = new StringBuilder();
        for (int i = 0; i < nodesTraversedSize(); i++) {
            outputString.append(getNode(i)).append("\n");
        }
        return outputString.toString();
    }
}

public class SimulatedAnnealing {
    public static double acceptProbability(int e,int ne,double temp) {
        if(ne<e) {
            return 1.0;
        }
        return Math.exp((e-ne)/temp);
    }

    public static void main(String[] args) {
        for(int i=0;i<10;i++) {
            Node n = new Node(i);
            NodeList.addNode(n);
        }

        NodeTraversed curr = new NodeTraversed();
        curr.generateNodes();

        NodeTraversed best = new NodeTraversed(curr.getNodesTraversed());

        for(int i=1000;i>1;i*=1-0.0005) {
            NodeTraversed near = new NodeTraversed(curr.getNodesTraversed());

            int pos1 = (int) (Math.random() * near.nodesTraversedSize());
            int pos2 = (int) (Math.random() * near.nodesTraversedSize());

            Node n1 = near.getNode(pos1);
            Node n2 = near.getNode(pos2);

            n1.swap();
            n2.swap();

            near.setNode(pos1,n1);
            near.setNode(pos2,n2);

            int currDiffHW = curr.diff()[0];
            int currDiffSW = curr.diff()[1];
            int nearDiffHW = near.diff()[0];
            int nearDiffSW = near.diff()[1];

            if( (acceptProbability(currDiffHW,nearDiffHW,i)>Math.random()) && (acceptProbability(currDiffSW,nearDiffSW,i)>Math.random()) ) {
                curr = new NodeTraversed(near.getNodesTraversed());
            }

            if(curr.diff()[0] < best.diff()[0] && curr.diff()[1] < best.diff()[1]) {
                best = new NodeTraversed(curr.getNodesTraversed());
            }
        }

        double[] arr = new double[2];
        arr[0] = best.diff()[0];
        arr[1] = best.diff()[1];
        double sum = arr[0]+arr[1];
        arr[0] = (arr[0]/sum)*100.0;
        arr[1] = (arr[1]/sum)*100.0;

        System.out.println(String.format("Total Cost:\n HW - %.02f SW - %.02f",arr[0],arr[1]));
        // System.out.println("Various Operations: \n" + best);
    }
}