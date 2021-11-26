import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "toggle" ]

    // toggle_controller.js works as follows:
    // 
    // The element that calls toggle() should have a
    // data-toggle-target-schemes attribute in the format:
    //
    // "<target_toggle_id>|<toggle_group> <target_toggle_id>|<toggle_group> ..."
    //
    // Each space delimited segment represents a toggle scheme this element targets.
    // Each toggle scheme can toggle different classes on different elements in different ways.
    //
    // All toggleTargets should have a data-toggle-schemes attribute in the format:
    //
    // "<toggle_id>|<toggle_class>|<toggle_group>|<toggle_default> <toggle_id>|<toggle_class>|<toggle_group>|<toggle_default> ..."
    //
    // Each space delimited segment represents a toggle scheme this element subscribes to. 
    //
    // The toggle schema always has a toggle_id and toggle_class, but may omit the toggle_group and toggle_default if
    // group toggling is not desired.
    //
    // Each toggle scheme of each toggleTarget will be evaluated against each toggle scheme in 
    // of the triggering element, trying to match on toggle_id first, then on toggle_group.
    //
    // If a match on toggle_id is found, the toggle_class is toggled on the target element. If no match on toggle_id is
    // found, but a match on toggle_group is found (if it exists in the target's toggle scheme), then the toggle_class is either 
    // added or removed from the target element depending on the toggle_default. The toggle_default should be either 
    // "on" or "off". If it is "on" then the class is added, and if it is "off" then the class is removed.
    // 
    // Using both unique target_ids in conjunction with toggle_groups allows one element (or a group of related elements) 
    // to be toggled while all other elements are turned to their default state to ensure only one is toggled on at a time.
    //
    // For binary relationships where one or another element is toggled, just toggle_id is sufficient as long as
    // both elements start with opposite states.
    //
    // To make a toggle scheme that toggles a group of elements to their default state but does not toggle any specific element 
    // (i.e. a "hide all" or "Cancel" button), use "_" as the target_toggle_id and don't use "_" as the toggle_id in any toggleTargets.
    // This is especially useful when multiple toggle_schemes use the same toggle_class and you can't rely on the result of simply
    // toggling that class because you don't know if it is toggled on or off.
    //
    // For example, a "hide all" button might have:
    //
    // data-toggle-target-schemes: "_|list-items"
    //
    // and there could be several toggleTargets with:
    //
    // data-toggle-schemes: "list-item-<%= item.id %>|hidden|list-items|on"
    //
    // and a heading or icon for each list item that, when clicked, reveals the list item with:
    //
    // data-toggle-target-schemes: "list-item-<%= item.id %>"
    //
    // The above toggle scheme would allow each list item to be toggled individually, and also allow
    // the "Hide all" button to toggle them all to their default state by adding their toggle_class,
    // regardless of whether they were toggled or not.
    //
    // Note, if you wanted only one list item to be toggled at a time, you can add a toggle_group to
    // heading or icon to make all targets return to their default state when ever one is toggled:
    //
    // data-toggle-target-schemes: "list-item-<%= item.id %>|list-items"
    //
    toggle(event){
        event.preventDefault();
        var toggleTargetSchemes = event.currentTarget.dataset.toggleTargetSchemes.split(" ");
        toggleTargetSchemes.forEach(targetScheme => {
            let toggleTargetTokens = targetScheme.split("|");
            let toggleTargetId = toggleTargetTokens[0];
            let toggleGroup = toggleTargetTokens[1];
    
            this.toggleTargets.forEach(target => {
                var toggleSchemes = target.dataset.toggleSchemes.split(" ");
                toggleSchemes.forEach(scheme => {
                    let toggleTokens = scheme.split("|")
                    if(toggleTargetId === toggleTokens[0]){ // Toggles the specified class on the matching element(s)
                        target.classList.toggle(toggleTokens[1]);
                    } else if (toggleGroup === toggleTokens[2]){ // This case toggles things back to their default state
                        if(toggleTokens[3] === "on"){
                            target.classList.add(toggleTokens[1]);
                        } else if(toggleTokens[3] === "off"){
                            target.classList.remove(toggleTokens[1]);
                        }
                    }
                })
            })
        })
    }
}