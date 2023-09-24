import 'package:supabase_flutter/supabase_flutter.dart';

const String supabaseUrl = "https://mrknrtgzkodxcpgwtvrp.supabase.co";
const String supabaseAnonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ya25ydGd6a29keGNwZ3d0dnJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI5MDEyMzIsImV4cCI6MjAwODQ3NzIzMn0.dE5-68-h5AQ0ScIBzh60-fNPBoovXivjPh2p1OxWig0";

//--Client to access Supabase Database and Auth--
final client = Supabase.instance.client;
final Session? session = client.auth.currentSession;
final User? user = client.auth.currentUser;
