{ ... }:
{
  programs.zk = {
    enable = true;
    settings = {
      note = {
        language = "en";
        default-title = "untitled";
        filename = "{{title}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 4;
        id-case = "lower";
      };
      tool = {
        editor = "nvim";
        shell = "/etc/profile/per-user/tesdap/bin/zsh";
      };
      alias = {
        # Edit the last modified note.
        edlast = "zk edit --limit 1 --sort modified- $@";

        # Edit the notes selected interactively among the notes created the last two weeks.
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

        # Show a random note.
        lucky = "zk list --quiet --format full --sort random --limit 1";
      };
      format.markdown = {
        link-format = "[[{{filename}}]]";
      };
      lsp.diagnostic = {
        wiki-title = "hint";
        dead-link = "error";
      };
      extra = {
        author = "Petter Tesdal";
      };
    };
  };
}
