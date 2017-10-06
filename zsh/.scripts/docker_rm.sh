function __delete_exited_containers() {
  docker rm $(docker ps -a -q --filter status=exited)
}

function __delete_all_containers_for_image() {
  docker rm $(docker ps -a -q -f "ancestor= $1")
}

function __delete_unused_images() {
  all_images=$(docker images -q)
  echo "$all_images" | while IFS= read -r image ; do
    containers=$(docker ps -a -q -f "ancestor= $image")
    if [[ -z $containers ]]; then
      docker rmi $image
    fi
  done
}

function __delete_dangling_images() {
  docker rmi $(docker images -q --filter "dangling=true")
}

function drm() {
  USAGE=" drm [OPTION]\n
  Options:
    cs \t Remove exited containers
    ci \t Remove all containers using image
    iu \t Remove images not being used by containers
    id \t Remove all dangling images
  "
  case $1 in
    iu)
      echo 'Removing unused images'
      __delete_unused_images
      ;;
    id)
      echo 'Removing dangling images'
      __delete_dangling_images
      ;;
    cs)
      echo 'Removing all exited containers'
      __delete_exited_containers
      ;;
    ci)
      if [[ -z $2 ]]; then
        echo 'Image id required'
        echo 'Usage: drm ci <image id>'
        return 1
      fi
      echo "Removing all containers for image $2"
      __delete_all_containers_for_image $2
      ;;
    *)
      echo "$USAGE"
      ;;
  esac
}
