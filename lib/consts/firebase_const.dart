import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//user
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;
//Store
FirebaseAuth storeAuth = FirebaseAuth.instance;
FirebaseFirestore storeFirestore = FirebaseFirestore.instance;
User? currntstore = auth.currentUser;

// User Collections...
const userCollection = 'users';
const productsCollection = 'products';
const cartCollection = 'cart';
const chatsCollection = 'chats';
const messagesCollection = 'messages';
const ordersCollection = 'orders';
// Store Collections...
const vendorCollection = 'vendor';
const sellerproductsCollection = 'products';
const sellercartCollection = 'cart';
const sellerchatsCollection = 'chats';
const sellermessagesCollection = 'messages';
const sellerordersCollection = 'orders';
