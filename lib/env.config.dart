library skillspro_config;

const bool isDev = true;
const bool isTest = true;
const baseUrl = isDev ? 'http://d783-102-216-201-40.ngrok.io' : 'http://ec2-18-134-242-9.eu-west-2.compute.amazonaws.com:7000/api/v1';
const FACEBOOK_GRAPH_API =
    "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=##";

