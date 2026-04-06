function rsh --wraps='gcloud compute ssh' --description 'alias rsh=gcloud compute ssh'
    gcloud compute ssh $argv
end
